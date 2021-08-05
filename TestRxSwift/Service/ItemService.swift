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
}
