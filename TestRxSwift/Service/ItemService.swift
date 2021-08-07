//
//  JsonService.swift
//  TestRxSwift
//
//  Created by Илья Кадыров on 04.08.2021.
//

import Foundation
import Alamofire

class ItemService {
    
    func loadAllItemData(completion: @escaping (AFDataResponse<GetItemsResponse>) -> Void) {
        
        AF.request(ServerSettingEnum.getAllItems.rawValue).responseDecodable(completionHandler: completion)
        
    }
    
    func sortItemByOrder(getItemsResponse: GetItemsResponse) -> [Item] {
        var sortedItems = [Item]()
        for orderItem in getItemsResponse.view {
            if let indexArr = getItemsResponse.data.firstIndex(where: { $0.name == orderItem }) {
                let sortedData = getItemsResponse.data[indexArr]
                sortedItems.append(sortedData)
            }
        }
        return sortedItems
    }
}
