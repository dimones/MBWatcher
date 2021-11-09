//
//  BaseParser.swift
//  
//
//  Created by Богомолов Дмитрий Александрович on 08.11.2021.
//

import Foundation

class BaseParser
{
	let downloader = HTMLDownloader()
	let books: [MBResult]
	let store: Store

	init(books: [MBResult], store: Store) {
		self.books = books
		self.store = store
	}
}
