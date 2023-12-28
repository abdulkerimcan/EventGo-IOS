//
//  SettingsVC.swift
//  EventGo
//
//  Created by Abdulkerim Can on 20.10.2023.
//

import UIKit
import SnapKit

protocol SettingsVCDelegate: AnyObject, AlertPresentable {
    func configureVC()
    func navigateToLogin()
}

final class SettingsVC: UIViewController {
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    private let editProfileView = CustomItemTileView(imageName: "person.fill", name: "Edit Profile")
    
    private let termsAndConditionsView = CustomItemTileView(imageName: "checkmark.seal.fill", name: "Terms & Conditions")
    
    private let privacyPolicyView = CustomItemTileView(imageName: "exclamationmark.lock.fill", name: "Privacy Policy")
    
    private let aboutUsView = CustomItemTileView(imageName: "questionmark.app.fill", name: "About Us")
    
    private let logoutView = CustomItemTileView(imageName: "rectangle.portrait.and.arrow.forward", name: "Log out",color: .systemRed)
    
    private lazy var viewModel = SettingsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
    //MARK: Selector Methods
    @objc private func didTapEditProfileview() {
        DispatchQueue.main.async {
            let vc = EditProfileVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc private func didTapLogoutView() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Log out", message: "Are you sure want to log out?", preferredStyle: .alert)
            alert.addAction(.init(title: "Yes", style: .default,handler: { _ in
                self.viewModel.logout()
            }))
            alert.addAction(.init(title: "No", style: .cancel))
            self.present(alert, animated: true)
        }
    }
    
    @objc private func didTapTermsAndConditionsView() {
        DispatchQueue.main.async {
            let vc = TermsAndConditionsVC()
            self.present(vc, animated: true)
        }
    }
    
    @objc private func didTapPrivacyPolicyView() {
        DispatchQueue.main.async {
            let vc = PrivacyPolicyVC()
            self.present(vc, animated: true)
        }
    }
    
    @objc private func didTapAboutUsView() {
        DispatchQueue.main.async {
            let vc = AboutUsVC()
            self.present(vc, animated: true)
        }
    }
}

extension SettingsVC: SettingsVCDelegate {
    
    func navigateToLogin() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                sceneDelegate.checkCurrentUser()
                
            }
        }
    }
    
    func configureVC() {
        title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = UIColor(named: "secondaryMainColor")
        
        view.addSubviews(
            editProfileView,
            termsAndConditionsView,
            privacyPolicyView,
            aboutUsView,
            logoutView
        )
        
        editProfileView.isUserInteractionEnabled = true
        let editProfileGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapEditProfileview))
        editProfileView.addGestureRecognizer(editProfileGestureRecognizer)
        editProfileView.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            make.right.equalTo(-20)
            make.height.equalTo(30)
        }
        
        termsAndConditionsView.isUserInteractionEnabled = true
        let termsAndConditionsViewGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapTermsAndConditionsView))
        termsAndConditionsView.addGestureRecognizer(termsAndConditionsViewGestureRecognizer)
        termsAndConditionsView.snp.makeConstraints { make in
            make.left.right.equalTo(editProfileView)
            make.top.equalTo(editProfileView.snp.bottom).offset(40)
            make.height.equalTo(30)
        }
        
        privacyPolicyView.isUserInteractionEnabled = true
        let privacyPolicyViewGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapPrivacyPolicyView))
        privacyPolicyView.addGestureRecognizer(privacyPolicyViewGestureRecognizer)
        privacyPolicyView.snp.makeConstraints { make in
            make.left.right.equalTo(termsAndConditionsView)
            make.top.equalTo(termsAndConditionsView.snp.bottom).offset(40)
            make.height.equalTo(30)
        }
        
        aboutUsView.isUserInteractionEnabled = true
        let aboutUsViewGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapAboutUsView))
        aboutUsView.addGestureRecognizer(aboutUsViewGestureRecognizer)
        aboutUsView.snp.makeConstraints { make in
            make.left.right.equalTo(privacyPolicyView)
            make.top.equalTo(privacyPolicyView.snp.bottom).offset(40)
            make.height.equalTo(30)
        }
        
        logoutView.isUserInteractionEnabled = true
        let logoutGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapLogoutView))
        logoutView.addGestureRecognizer(logoutGestureRecognizer)
        logoutView.snp.makeConstraints { make in
            make.left.right.equalTo(privacyPolicyView)
            make.top.equalTo(aboutUsView.snp.bottom).offset(40)
            make.height.equalTo(30)
        }
    }
}
