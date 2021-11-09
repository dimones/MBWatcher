//
//  Fetcher.swift
//  
//
//  Created by Богомолов Дмитрий Александрович on 09.11.2021.
//

import Foundation

final class Fetcher: Thread
{
	private let bot: TGBot
	private let parsers: [IParser]

	init(bot: TGBot) {
		self.bot = bot
		self.parsers = [
			MvideoParser(books: Configuration.booksToFind, store: .mvideo),
			ReStoreParser(books: Configuration.booksToFind, store: .reStore),
		]
	}

	override func start() {
		self.fetch()
	}
}

private extension Fetcher
{
	func fetch() {
		while true {
			let results = parsers.compactMap { parser -> StoreResult? in
				let result = parser.parse()
				guard let parser = parser as? BaseParser else { return nil }

				return StoreResult(store: parser.store, books: result)
			}

			results.forEach { storeResult in
				let adoptedMessage = storeResult.books.map { book -> String in
					let adopted = book.adopt(to: storeResult.store)

					return adopted
				}.joined(separator: "\n")

				let message = "Результат поиска в магазе: \(storeResult.store.rawValue)\n\(adoptedMessage)"

				if !storeResult.books.isEmpty {
					self.bot.informUsers(message: message)
				}
				else {
					print("Ничего не найдено в магазине: \(storeResult.store.rawValue)")
				}
			}

			Thread.sleep(forTimeInterval: Configuration.fetchInterval)
		}
	}
}
