//
//  SceneDelegate.swift
//  EventGo
//
//  Created by Abdulkerim Can on 8.10.2023.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        setupScene(with: scene)
        UserDefaults.standard.bool(forKey: "isFirstUser") ? checkCurrentUser() : goToController(on: OnboardVC())
    }
    
    private func goToController(on vc: UIViewController) {
        
        DispatchQueue.main.async {
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            nav.navigationBar.isHidden = true
            self.window?.rootViewController = nav
        }
    }
    
    func checkCurrentUser() {
        if Auth.auth().currentUser == nil {
            goToController(on: LoginVC())
        } else {
            goToController(on: TabbarVC())
        }
    }
    
    private func setupScene(with scene: UIScene) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.makeKeyAndVisible()
    }
}

