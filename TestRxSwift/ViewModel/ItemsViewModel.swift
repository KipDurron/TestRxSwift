//
//  ItemsViewModel.swift
//  TestRxSwift
//
//  Created by Илья Кадыров on 04.08.2021.
//

import RxSwift
import RxCocoa

class ItemsViewModel {
    
    let itemService = ItemService()
    public let items: PublishSubject<[Item]> = PublishSubject()
    public let error : PublishSubject<TypeErrorEnum> = PublishSubject()
    
    func startGetAllItem() {
        itemService.loadAllItemData { [weak self] (response) in
           switch response.result {
           case .success(let result):
            if let loadItems = self?.itemService.sortItemByOrder(getItemsResponse: result) {
                self?.items.onNext(loadItems)
            }
           case .failure(let error):
            self?.error.onNext(.serverMessage("\(error)"))
           }
        }
    }
    
}
