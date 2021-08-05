//
//  AlertService.swift
//  TestRxSwift
//
//  Created by Илья Кадыров on 05.08.2021.
//

import UIKit

class AlertFactory {
    
    func makeErrorAlert(text: String) -> UIAlertController {
        let alert = UIAlertController(title: "🤬 Error", message: text, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(actionOk)
        return alert
    }

    func makeMessageAlert(text: String) -> UIAlertController {
        let alert = UIAlertController(title: "💕 Message", message: text, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(actionOk)
        return alert
    }
}
