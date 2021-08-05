//
//  JsonService.swift
//  TestRxSwift
//
//  Created by Илья Кадыров on 04.08.2021.
//

import Foundation
import Alamofire

class ItemService {
    
    func loadAllItemData(completion: @escaping (AFDataResponse<GetItemsResponse>) -> Void) -> DataRequest{

//        AF.request(ServerSettingEnum.getAllItems.rawValue).responseDecodable(of: GetItemsResponse.self) { response in
//            guard let itemsResponse = response.value else {
//                return
//            }
//            completion(itemsResponse)
//        }
        
        return AF.request(ServerSettingEnum.getAllItems.rawValue).responseDecodable(completionHandler: completion)
        
    }
}
