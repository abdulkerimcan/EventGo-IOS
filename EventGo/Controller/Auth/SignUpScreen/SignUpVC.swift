//
//  ViewController.swift
//  EventGo
//
//  Created by Abdulkerim Can on 8.10.2023.
//

import UIKit
import SnapKit

protocol SignUpVCDelegate: AnyObject,AlertPresentable {
    func configureVC()
    func configureUI()
    func navigateToLogin()
    func navigateToHomeScreen()
    func configureSpinner()
    func startSpinner()
    func stopSpinner()
}

final class SignUpVC: UIViewController {
    
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
    
    private lazy var headerView = AuthHeaderView(title: "Sign Up",
                                                 subtitle: "Sign up for free")
    
    private lazy var emailTF = AuthTextField(textFieldType: .email)
    
    private lazy var fullNameTF = CustomTextField(placeHolder: "Full name")
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.minimumDate = Calendar.current.date(byAdding: .year, value: -100, to: .now) ?? .now
        datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: -18, to: .now) ?? .now
        datePicker.date = Calendar.current.date(byAdding: .year, value: -18, to: .now) ?? .now
        datePicker.preferredDatePickerStyle = .inline
        return datePicker
    }()
    
    private lazy var dropDown: GenderDropDown = {
        let gender = GenderDropDown(frame: .zero)
        return gender
    }()
    
    private lazy var dateOfBirthTF = CustomTextField(placeHolder: "Date of Birth")
    
    private lazy var passwordTF = AuthTextField(textFieldType: .password)
    
    private lazy var signUpBtn = CustomButton(title: "Sign up",
                                              hasBackground: true,
                                              fontSize: .large)
    
    private lazy var loginBtn = CustomButton(title: "Already have an account?",
                                             hasBackground: false,
                                             fontSize: .small)
    
    private lazy var viewModel = SignUpViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
    //MARK: Selector methods
    @objc private func didTapDateOfBirth() {
        let dateString = viewModel.didTapDateOfBirth(date: datePicker.date)
        dateOfBirthTF.text = dateString
        view.endEditing(true)
    }
    
    @objc func didTapLoginBtn() {
        navigateToLogin()
    }
    
    @objc func didTapSignUpBtn() {
        guard let email = emailTF.text,
        !email.isEmpty else {
            showAlert(title: "Error",
                      message: "Mail cannot be empty",
                      okAction: {
                
            })
            return
        }
        guard let fullname = fullNameTF.text,
        !fullname.isEmpty else {
            showAlert(title: "Error",
                      message: "Fullname cannot be empty",
                      okAction: {
                
            })
            return
        }
        guard let genderIndex = dropDown.selectedIndex else {
            showAlert(title: "Error",
                      message: "Gender cannot be empty",
                      okAction: {
                
            })
            return
        }
        let gender = dropDown.genderArray[genderIndex]
        
        guard let birthDay = dateOfBirthTF.text,
              !birthDay.isEmpty else {
            showAlert(title: "Error",
                      message: "Birthday cannot be empty",
                      okAction: {
                
            })
            return
        }
        
        guard let password = passwordTF.text else {
            showAlert(title: "Error",
                      message: "Password cannot be empty",
                      okAction: {
                
            })
            return
        }
        
        viewModel.validate(email: email,
                           password: password)
        
        viewModel.register(email: email,
                           fullname: fullname,
                           gender: gender.rawValue,
                           birthDay: birthDay,
                           password: password)
    }
}

extension SignUpVC: SignUpVCDelegate{
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
                         loginBtn)
        
        column.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.left.equalTo(20)
            make.right.equalTo(-20)
        }
        column.addArrangedSubviews(headerView,
                                   emailTF,
                                   fullNameTF,
                                   dropDown,
                                   dateOfBirthTF,
                                   passwordTF,
                                   signUpBtn)
        
        headerView.snp.makeConstraints { make in
            make.height.equalTo(200)
        }
        
        emailTF.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        fullNameTF.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        dropDown.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        let dateToolbar = UIToolbar()
        dateToolbar.sizeToFit()
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done,
                                      target: self,
                                      action: #selector(didTapDateOfBirth))
        dateToolbar.setItems([doneBtn],
                             animated: true)
        
        let dateImageView = UIImageView(image: UIImage(systemName: "calendar"))
        
        dateImageView.tintColor = .label
        dateOfBirthTF.rightView = dateImageView
        dateOfBirthTF.rightViewMode = .always
        dateOfBirthTF.inputView = datePicker
        dateOfBirthTF.inputAccessoryView = dateToolbar
        dateOfBirthTF.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        passwordTF.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        signUpBtn.addTarget(self,
                            action: #selector(didTapSignUpBtn),
                            for: .touchUpInside)
        
        signUpBtn.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        loginBtn.addTarget(self,
                           action: #selector(didTapLoginBtn),
                           for: .touchUpInside)
        loginBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-50)
            make.left.right.equalTo(column)
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
            self.present(loginVC,
                         animated: true,
                         completion: nil)
        }
    }
}
