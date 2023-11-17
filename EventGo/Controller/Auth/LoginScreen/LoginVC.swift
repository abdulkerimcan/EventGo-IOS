//
//  ViewController.swift
//  EventGo
//
//  Created by Abdulkerim Can on 8.10.2023.
//

import UIKit
import SnapKit

protocol LoginVCDelegate: AnyObject,AlertPresentable {
    
    func configureVC()
    func configureUI()
    func navigateToSignUp()
    func navigateToHomeScreen()
    func configureSpinner()
    func startSpinner()
    func stopSpinner()
}

final class LoginVC: UIViewController {
    
    private lazy var column: UIStackView = {
        let column = UIStackView()
        column.axis = .vertical
        column.spacing = 20
        return column
    }()
    
    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        spinner.style = .large
        return spinner
    }()
    
    private lazy var headerView = AuthHeaderView(title: "Sign In", subtitle: "Login to your account")
    
    private lazy var passwordTF = AuthTextField(textFieldType: .password)
    
    private lazy var emailTF = AuthTextField(textFieldType: .email)
    
    private lazy var loginBtn = CustomButton(title: "Login", hasBackground: true, fontSize: .large)
    
    private lazy var forgetPasswordBtn = CustomButton(title: "Forget the password?", hasBackground: false, fontSize: .medium)
    
    private lazy var signUpBtn = CustomButton(title: "Don't you have an account?", hasBackground: false, fontSize: .small)
    
    private lazy var viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
        
    }
    
    //MARK: Selector methods
    @objc func didTapLoginBtn() {
        guard let email = emailTF.text, let password = passwordTF.text else {
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
    func configureSpinner() {
        view.addSubview(spinner)
        view.bringSubviewToFront(spinner)
        spinner.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    func startSpinner() {
        spinner.startAnimating()
        column.alpha = 0.5
    }
    
    func stopSpinner() {
        
        spinner.stopAnimating()
        column.alpha = 1
    }
    
    
    func configureVC() {
        view.backgroundColor = .secondaryMain
        navigationController?.navigationBar.isHidden = false
    }
    
    func configureUI() {
        
        view.addSubviews(column,
                         signUpBtn)
        column.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.left.equalTo(20)
            make.right.equalTo(-20)
        }
        column.addArrangedSubviews(headerView,
                                   emailTF,
                                   passwordTF,
                                   loginBtn,
                                   forgetPasswordBtn)
        
        headerView.snp.makeConstraints { make in
            make.height.equalTo(200)
        }
        
        emailTF.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        passwordTF.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        forgetPasswordBtn.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        forgetPasswordBtn.addTarget(self, action: #selector(didTapForgotPasswordBtn), for: .touchUpInside)
        
        loginBtn.addTarget(self, action: #selector(didTapLoginBtn) , for: .touchUpInside)
        loginBtn.snp.makeConstraints { make in
            make.top.equalTo(passwordTF.snp.bottom).offset(20)
            make.left.right.equalTo(passwordTF)
            make.height.equalTo(50)
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
}
