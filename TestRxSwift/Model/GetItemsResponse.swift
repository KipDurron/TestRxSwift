//
//  GetItemsResponse.swift
//  TestRxSwift
//
//  Created by Илья Кадыров on 04.08.2021.
//

import Foundation

struct GetItemsResponse: Decodable {
    let view: [String]
    let data: [Item]
    
    enum CodingKeys: String, CodingKey {
        case view = "view"
        case data = "data"
    }
    
}
