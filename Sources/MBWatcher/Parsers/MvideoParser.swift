//
//  MvideoParser.swift
//  
//
//  Created by Богомолов Дмитрий Александрович on 08.11.2021.
//

import Foundation
import SwiftSoup

final class MvideoParser: BaseParser, IParser
{
	let link: String = "https://www.mvideo.ru/promo/noutbuki-apple-macbook-pro-14-i-16?from=hb"

	func parse() -> [MBResult] {
		do {
			let soup = try self.downloader.makeSoup(from: self.link)

			return try soup
				.select("[^data-product-id]")
				.array()
				.compactMap { el -> MBResult? in
					let titleNode = try el.select(".fl-product-tile-title__link")
					let availability = try el.select(".fl-product-tile-delivery__item")

					let foundBook = try self.books.first { book in
						let adoptedTitle = book.adopt(to: self.store)

						return try titleNode.text().contains(adoptedTitle) && !availability.array().isEmpty
					}
					return foundBook
				}
		} catch {
			print("Произошла ошибка: \(error.localizedDescription)")
			return []
		}
	}
}
