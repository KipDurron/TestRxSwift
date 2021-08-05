//
//  ItemsViewModel.swift
//  TestRxSwift
//
//  Created by Илья Кадыров on 04.08.2021.
//

import RxSwift
import RxCocoa

class ItemsViewModel {
    
    public enum HomeError {
           case internetError(String)
           case serverMessage(String)
       }
    public let itemsResponse : PublishSubject<GetItemsResponse> = PublishSubject()
    
}
