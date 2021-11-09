//
//  HTMLDownloader.swift
//  
//
//  Created by Богомолов Дмитрий Александрович on 08.11.2021.
//

import Foundation
import SwiftSoup
#if os(Linux)
import FoundationNetworking
#endif

final class HTMLDownloader
{
	enum Errors: Swift.Error
	{
		case downloadError
	}

	private let session = URLSession.shared

	func download(from link: String) throws -> String {
		let (data, _, oError) = URLSession.shared.synchronousDataTask(with: URL(string: link)!)

		guard let error = oError else {
			guard let data = data else {
				throw Errors.downloadError
			}

			return String(data: data, encoding: .utf8)!
		}

		throw error
	}

	func makeSoup(from link: String) throws -> SwiftSoup.Document {
		return try SwiftSoup.parse(try self.download(from: link))
	}
}

// Застилено с SO
extension URLSession {
	func synchronousDataTask(with url: URL) -> (Data?, URLResponse?, Error?) {
		var data: Data?
		var response: URLResponse?
		var error: Error?

		let semaphore = DispatchSemaphore(value: 0)

		let dataTask = self.dataTask(with: url) {
			data = $0
			response = $1
			error = $2

			semaphore.signal()
		}
		dataTask.resume()

		_ = semaphore.wait(timeout: .distantFuture)

		return (data, response, error)
	}
}
