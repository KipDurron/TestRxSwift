//
//  AllItemsInteractionProtocol.swift
//  TestRxSwift
//
//  Created by Илья Кадыров on 05.08.2021.
//

import Foundation

protocol AllItemsViewToPresenter: AnyObject {
    func startGetAllItem()
}

protocol AllItemsPresenterToView: AnyObject {
    func getAllItem(response: GetItemsResponse)
    func showMessage(text: String, messageType: MessageTypeEnum)
}
