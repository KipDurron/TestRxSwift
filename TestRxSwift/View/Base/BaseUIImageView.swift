//
//  BaseUIImageView.swift
//  TestRxSwift
//
//  Created by Илья Кадыров on 04.08.2021.
//

import UIKit

class BaseUIImageView: UIImageView {

    init() {
        super.init(frame: .zero)
        configuration()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configuration()
    }

    private func configuration() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

