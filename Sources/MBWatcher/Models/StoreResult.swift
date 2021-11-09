//
//  StoreResult.swift
//  
//
//  Created by Богомолов Дмитрий Александрович on 09.11.2021.
//

import Foundation

enum Store: String
{
	case mvideo = "МВидео"
	case reStore = "re:Store"
}

struct StoreResult
{
	let store: Store
	let books: [MBResult]
}
