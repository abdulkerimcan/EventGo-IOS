//
//  AlertPresentable.swift
//  EventGo
//
//  Created by Abdulkerim Can on 3.11.2023.
//

import UIKit

protocol AlertPresentable {
    func showAlert(title: String, message: String, okAction: @escaping () -> Void)
}

extension AlertPresentable where Self: UIViewController {
    func showAlert(title: String, message: String, okAction: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "ok", style: .default) { _ in
            okAction()
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
}

