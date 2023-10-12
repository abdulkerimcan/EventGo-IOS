//
//  ViewController.swift
//  EventGo
//
//  Created by Abdulkerim Can on 8.10.2023.
//

import UIKit
import SnapKit

protocol SignUpVCDelegate: AnyObject {
    
    func configureVC()
    func configureUI()
    func navigateToLogin()
    func navigateToHomeScreen()
    func showRegisterError(error: Error?)
    func showRegisterError()
    func showInvalidEmailError()
    func showInvalidPasswordError()
}

final class SignUpVC: UIViewController {
    
    private let headerView = AuthHeaderView(title: "Sign Up", subtitle: "Sign up for free")
    
    private var emailTextField = AuthTextView(textFieldType: .email)
    
    private let passwordTextField = AuthTextView(textFieldType: .password)
    
    private let signUpBtn = CustomButton(title: "Sign up", hasBackground: true, fontSize: .large)
    
    private let loginBtn = CustomButton(title: "Already have an account?", hasBackground: false, fontSize: .small)
    
    private lazy var viewModel = SignUpViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
    //MARK: Selector methods
    @objc func didTapLoginBtn() {
        navigateToLogin()
    }
    
    @objc func didTapSignUpBtn() {
        
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return
        }
        
        viewModel.validate(email: email, password: password)
        viewModel.register(email: email, password: password)
    }
    
}

extension SignUpVC: SignUpVCDelegate{
    
    func configureVC() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.isHidden = false
    }
    
    func configureUI() {
        view.addSubview(headerView)
        headerView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(100)
            make.height.equalTo(200)
        }
        
        view.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(10)
            make.height.equalTo(50)
            make.left.equalTo(16)
            make.right.equalTo(-16)
        }
        
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.left.right.equalTo(emailTextField)
            make.height.equalTo(50)
        }
        
        view.addSubviews(loginBtn,signUpBtn)
        signUpBtn.addTarget(self, action: #selector(didTapSignUpBtn), for: .touchUpInside)
        signUpBtn.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.left.right.equalTo(passwordTextField)
            make.height.equalTo(50)
        }
        
        loginBtn.addTarget(self, action: #selector(didTapLoginBtn), for: .touchUpInside)
        loginBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-50)
            make.left.right.equalTo(signUpBtn)
        }
    }
    
    //MARK: Navigation functions
    func navigateToHomeScreen() {
        
        if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
            sceneDelegate.checkCurrentUser()
        }
    }
    
    func navigateToLogin() {
        
        DispatchQueue.main.async {
            let loginVC = LoginVC()
            loginVC.modalPresentationStyle = .fullScreen
            self.present(loginVC, animated: true,completion: nil)
        }
    }
    
    //MARK: Error Alerts
    func showInvalidEmailError() {
        AlertManager.shared.showInvalidEmailAlert(on: self)
    }
    
    func showInvalidPasswordError() {
        AlertManager.shared.showInvalidPasswordAlert(on: self)
    }
    
    func showRegisterError() {
        AlertManager.shared.showRegisterErrorAlert(on: self)
    }
    
    func showRegisterError(error: Error?) {
        AlertManager.shared.showRegisterErrorAlert(on: self, error: error)
    }
}
