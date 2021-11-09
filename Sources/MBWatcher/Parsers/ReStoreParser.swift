//
//  ReStoreParser.swift
//  
//
//  Created by Богомолов Дмитрий Александрович on 09.11.2021.
//

import Foundation

final class ReStoreParser: BaseParser, IParser
{
	let link: String = "https://re-store.ru/apple-mac/macbooks/type_macbook-pro/year_2021/"
	//Запасной адрес, где больше ноутов
//	let link: String = "https://re-store.ru/apple-mac/macbooks/type_macbook-pro/"

	// Несмотря на большое количество анврапов, оно пущай так и работает
	func parse() -> [MBResult] {
		do {
			let soup = try self.downloader.makeSoup(from: self.link)

			let scriptElement = try soup.select("[data-skip-moving=true]").array()[1]

			let jsonString = try scriptElement.html()
				.split(separator: ";")
				.map(String.init)
				.map { $0.replacingOccurrences(of: "window.digitalData = ", with: "")}[0]

			let json = try JSONSerialization
				.jsonObject(with: jsonString.data(using: .utf8)!, options: []) as! [String: Any]


			let items = (json["listing"] as! [String: Any])["items"] as! [[String: Any]]

			return items.compactMap { item -> MBResult? in
				guard let name = item["name"] as? String, let stock = item["stock"] as? Int else {
					return nil
				}

				return self.books.first { book in
					let adopted = book.adopt(to: self.store)

					return name.contains(adopted) && stock == 1
				}
			}
		} catch {
			print("Произошла ошибка: \(error.localizedDescription)")
			return []
		}
	}
}
