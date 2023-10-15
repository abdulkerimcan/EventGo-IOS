//
//  ViewController.swift
//  EventGo
//
//  Created by Abdulkerim Can on 8.10.2023.
//

import UIKit
import SnapKit

protocol LoginVCDelegate: AnyObject {
    
    func configureVC()
    func configureUI()
    func navigateToSignUp()
    func navigateToHomeScreen()
    func showLoginError(error: Error?)
    func showInvalidEmailError()
    func showInvalidPasswordError()
}

final class LoginVC: UIViewController {
    
    private let headerView = AuthHeaderView(title: "Sign In", subtitle: "Login to your account")
    
    private let passwordTextField = AuthTextField(textFieldType: .password)
    
    private var emailTextField = AuthTextField(textFieldType: .email)
    
    private let loginBtn = CustomButton(title: "Login", hasBackground: true, fontSize: .large)
    
    private let forgetPasswordBtn = CustomButton(title: "Forget the password?", hasBackground: false, fontSize: .medium)
    
    private let signUpBtn = CustomButton(title: "Don't you have an account?", hasBackground: false, fontSize: .small)
    
    private lazy var viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
        
    }
    
    //MARK: Selector methods
    @objc func didTapLoginBtn() {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return
        }
        viewModel.validate(email: email, password: password)
        viewModel.login(email: email, password: password)
        
        
    }
    
    @objc func didTapSignUpBtn() {
        navigateToSignUp()
    }
    
    @objc func didTapForgotPasswordBtn() {
        print("tapped forgot password")
    }
}

extension LoginVC: LoginVCDelegate {
    
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
        
        view.addSubviews(loginBtn,signUpBtn,forgetPasswordBtn)
        
        loginBtn.addTarget(self, action: #selector(didTapLoginBtn) , for: .touchUpInside)
        loginBtn.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.left.right.equalTo(passwordTextField)
            make.height.equalTo(50)
        }
        
        forgetPasswordBtn.addTarget(self, action: #selector(didTapForgotPasswordBtn), for: .touchUpInside)
        forgetPasswordBtn.snp.makeConstraints { make in
            make.top.equalTo(loginBtn.snp.bottom).offset(10)
            make.left.right.equalTo(loginBtn)
        }
        signUpBtn.addTarget(self, action: #selector(didTapSignUpBtn) , for: .touchUpInside)
        signUpBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-50)
            make.left.right.equalTo(forgetPasswordBtn)
        }
    }
    
    // MARK: Navigation functions
    func navigateToHomeScreen() {
        if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
            sceneDelegate.checkCurrentUser()
        }
    }
    
    func navigateToSignUp() {
        
        DispatchQueue.main.async {
            let signUpVC = SignUpVC()
            signUpVC.modalPresentationStyle = .fullScreen
            self.present(signUpVC, animated: true, completion: nil)
        }
        
    }
    
    //MARK: Error Alerts
    func showLoginError(error: Error?) {
        AlertManager.shared.showLoginErrorAlert(on: self, error: error)
    }
    
    func showInvalidEmailError() {
        AlertManager.shared.showInvalidEmailAlert(on: self)
    }
    
    func showInvalidPasswordError() {
        AlertManager.shared.showInvalidPasswordAlert(on: self)
    }
}
