//
//  SelectorData.swift
//  TestRxSwift
//
//  Created by Илья Кадыров on 04.08.2021.
//

import Foundation

struct SelectorData: Codable {
    let selectedId: Int
    let variants: [Variant]
}
