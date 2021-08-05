//
//  AllItemsPresenter.swift
//  TestRxSwift
//
//  Created by Илья Кадыров on 05.08.2021.
//

import Foundation

class AllItemsPresenter {
    private weak var controller: AllItemsPresenterToView?
    let itemService = ItemService()
    let alertFactory = AlertFactory()
    
    func setController(controller: AllItemsPresenterToView) {
        self.controller = controller
    }
}

extension AllItemsPresenter: AllItemsViewToPresenter {
    func startGetAllItem() {
        itemService.loadAllItemData { (response) in
            DispatchQueue.main.async { [weak self] in
                switch response.result {
                case .success(let result):
                    self?.controller?.getAllItem(response: result)
                case .failure(let error):
                    self?.controller?.showMessage(text: "\(error)", messageType: .error)
                }
            }
        }
    }
    

}
