//
//  AlertManager.swift
//  EventGo
//
//  Created by Abdulkerim Can on 9.10.2023.
//

import UIKit

final class AlertManager {
    static let shared = AlertManager()
    private init() {}
    
    func showBasicAlert(title: String, message: String?,on vc: UIViewController) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default,handler: nil))
            vc.present(alert, animated: false)
        }
    }
}

//MARK: Validation Alerts
extension AlertManager {
    func showInvalidEmailAlert(on vc: UIViewController) {
        showBasicAlert(title: "Invalid E-mail", message: "Please enter a valid e-mail", on: vc)
    }
    
    func showInvalidPasswordAlert(on vc: UIViewController) {
        showBasicAlert(title: "Invalid password", message: "Please enter a valid password", on: vc)
    }
}

//MARK: Registration Alerts
extension AlertManager {
    
    func showRegisterErrorAlert(on vc: UIViewController) {
        showBasicAlert(title: "Unknown Error ", message: nil, on: vc)
    }
    
    func showRegisterErrorAlert(on vc: UIViewController,error: Error?) {
        showBasicAlert(title: "Registration Error ", message: error?.localizedDescription, on: vc)
    }
}

//MARK: Login Alerts
extension AlertManager {
    
    func showLoginErrorAlert(on vc: UIViewController) {
        showBasicAlert(title: "Unknown Error Login ", message: nil, on: vc)
    }
    
    func showLoginErrorAlert(on vc: UIViewController,error: Error?) {
        showBasicAlert(title: "Login Error ", message: error?.localizedDescription, on: vc)
    }
}

//MARK: Logout Alerts
extension AlertManager {
    
    func showLogoutErrorAlert(on vc: UIViewController,error: Error?) {
        showBasicAlert(title: "Logout Error ", message: error?.localizedDescription, on: vc)
    }
}


