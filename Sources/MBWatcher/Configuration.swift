//
//  Configuration.swift
//  
//
//  Created by Богомолов Дмитрий Александрович on 09.11.2021.
//

import Foundation

class Configuration
{
	static let fetchInterval: TimeInterval = 60 * 5
	static let botSleep: TimeInterval = 10
	static let booksToFind: [MBResult] = [.mainBook(), .testBook(), .topBook()]
}
