//
//  SelectorViewModel.swift
//  TestRxSwift
//
//  Created by Илья Кадыров on 30.05.2022.
//

import RxSwift

class SelectorViewModel {
    public let selectedVariant: PublishSubject<Variant> = PublishSubject()
}
