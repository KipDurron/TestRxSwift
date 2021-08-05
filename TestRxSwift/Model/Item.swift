//
//  Item.swift
//  TestRxSwift
//
//  Created by Илья Кадыров on 04.08.2021.
//

import Foundation

struct Item: Decodable {
    let name: String
    let data: Any
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
            do {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                if let pictureData = try? container.decode(PictureData.self, forKey: .data) {
                    data = pictureData
                } else if let textData = try? container.decode(TextData.self, forKey: .data) {
                    data = textData
                } else if let selectorData = try? container.decode(SelectorData.self, forKey: .data) {
                    data = selectorData
                } else {
                    throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: container.codingPath,
                                                                            debugDescription: "Not a JSON"))
                }
                if let currentName = try? container.decode(String.self, forKey: .name) {
                    name = currentName
                } else {
                    throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: container.codingPath,
                                                                            debugDescription: "Not a JSON"))
                }
            }
        }
}
