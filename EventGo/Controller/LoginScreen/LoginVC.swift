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
    
}

final class LoginVC: UIViewController {
    
    private let headerView = AuthHeaderView(title: "Sign In", subtitle: "Login to your account")
    
    private let passwordTextField = AuthTextView(textFieldType: .password)
    
    private var nameTextField = AuthTextView(textFieldType: .email)
    
    private let signInBtn = AuthButton(title: "Login", hasBackground: true, fontSize: .large)
    
    private let forgetPasswordBtn = AuthButton(title: "Forget the password?", hasBackground: false, fontSize: .medium)
    
    private let signUpBtn = AuthButton(title: "Don't you have an account?", hasBackground: false, fontSize: .small)
    
    private lazy var viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
    //MARK: Selector methods
    @objc func didTapSignInBtn() {
        print("tapped sign in")
    }
    
    @objc func didTapSignUpBtn() {
        navigateToSignUp()
    }
    
    @objc func didTapForgotPasswordBtn() {
        print("tapped forgot password")
    }
}

extension LoginVC: LoginVCDelegate{
    
    func configureUI() {
        
        view.addSubview(headerView)
        headerView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(100)
            make.height.equalTo(200)
        }
        
        view.addSubview(nameTextField)
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(10)
            make.height.equalTo(50)
            make.left.equalTo(16)
            make.right.equalTo(-16)
        }
        
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(20)
            make.left.right.equalTo(nameTextField)
            make.height.equalTo(50)
        }
        
        view.addSubviews(signInBtn,signUpBtn,forgetPasswordBtn)
        
        signInBtn.addTarget(self, action: #selector(didTapSignInBtn) , for: .touchUpInside)
        signInBtn.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.left.right.equalTo(passwordTextField)
            make.height.equalTo(50)
        }
        
        forgetPasswordBtn.addTarget(self, action: #selector(didTapForgotPasswordBtn), for: .touchUpInside)
        forgetPasswordBtn.snp.makeConstraints { make in
            make.top.equalTo(signInBtn.snp.bottom).offset(10)
            make.left.right.equalTo(signInBtn)
        }
        signUpBtn.addTarget(self, action: #selector(didTapSignUpBtn) , for: .touchUpInside)
        signUpBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-50)
            make.left.right.equalTo(forgetPasswordBtn)
        }
    }
    
    func navigateToSignUp() {
        DispatchQueue.main.async {
            let signUpVC = SignUpVC()
            signUpVC.modalPresentationStyle = .fullScreen
            self.present(signUpVC, animated: true, completion: nil)
        }
    }
    
    func configureVC() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.isHidden = false
    }
}
