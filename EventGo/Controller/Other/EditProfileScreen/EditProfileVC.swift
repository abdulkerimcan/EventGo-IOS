//
//  EditProfileVC.swift
//  EventGo
//
//  Created by Abdulkerim Can on 20.10.2023.
//

import UIKit
import SnapKit
import iOSDropDown
import PhotosUI

protocol EditProfileVCDelegate: AnyObject {
    func configureVC()
    func configureProfileImageView()
    func configureDivider()
    func configureStackView()
    func configureTextfield()
    func configureDateOfBirth()
    func configureDropDown()
    func configureSaveChangesBtn()
    
}

final class EditProfileVC: UIViewController {
    
    private var profileImageView: UIImageView!
    
    private var editImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(systemName: "pencil")
        imageview.tintColor = UIColor(named: "mainColor")
        return imageview
    }()
    
    private let stackview: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 30
        return stack
    }()
    
    private let fullNameTF = CustomTextField(placeHolder: "Full name")
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.minimumDate = .now
        datePicker.preferredDatePickerStyle = .inline
        return datePicker
    }()
    
    private let dateOfBirthTF = CustomTextField(placeHolder: "Date of Birth")
    
    private var dropDown: GenderDropDown = {
        let gender = GenderDropDown(frame: .zero)
        return gender
    }()
    
    private let saveChangesBtn = CustomButton(title: "Save Changes", hasBackground: true, fontSize: .large)
    
    private let divider: UIView = {
        let divider = UIView()
        divider.backgroundColor = .tertiarySystemBackground
        return divider
    }()
    
    private lazy var viewModel = EditProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
    @objc private func didTapDateOfBirth() {
        let dateString = viewModel.didTapDateOfBirth(date: datePicker.date)
        dateOfBirthTF.text = dateString
        view.endEditing(true)
    }
    
    @objc private func didTapProfileImageView() {
        var config = PHPickerConfiguration()
        config.selectionLimit = 1
        let phPickerVC = PHPickerViewController(configuration: config)
        phPickerVC.delegate = self
        present(phPickerVC, animated: true)
    }
}

extension EditProfileVC: EditProfileVCDelegate {
    
    func configureVC() {
        title = "Edit Profile"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = UIColor(named: "secondaryMainColor")
    }
    
    func configureProfileImageView() {
        
        profileImageView = UIImageView(frame: .init(x: 0, y: 0, width: 150, height: 150))
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.clipsToBounds = true
        view.addSubview(profileImageView)
        
        profileImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.height.equalTo(150)
            make.width.equalTo(150)
        }
        profileImageView.image = UIImage(systemName: "person")
        profileImageView.tintColor = .black
        profileImageView.makeRounded()
        
        profileImageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapProfileImageView))
        profileImageView.addGestureRecognizer(gestureRecognizer)
        
    }
    
    func configureDivider() {
        
        view.addSubview(divider)
        
        divider.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(30)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(1)
        }
    }
    
    func configureStackView() {
        
        view.addSubview(stackview)
        stackview.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(divider.snp.bottom).offset(30)
        }
    }
    
    func configureTextfield() {
        
        stackview.addArrangedSubview(fullNameTF)
        
        fullNameTF.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
    }
    
    func configureDropDown() {
        stackview.addArrangedSubview(dropDown)
        
        dropDown.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        let dateToolbar = UIToolbar()
        dateToolbar.sizeToFit()
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapDateOfBirth))
        dateToolbar.setItems([doneBtn], animated: true)
        
        let dateImageView = UIImageView(image: UIImage(systemName: "calendar"))
        dateImageView.tintColor = .label
        dateOfBirthTF.rightView = dateImageView
        dateOfBirthTF.rightViewMode = .always
        dateOfBirthTF.inputView = datePicker
        dateOfBirthTF.inputAccessoryView = dateToolbar
    }
    
    func configureDateOfBirth() {
        stackview.addArrangedSubview(dateOfBirthTF)
        
        dateOfBirthTF.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
    }
    
    func configureSaveChangesBtn() {
        
        stackview.addArrangedSubview(saveChangesBtn)
        
        saveChangesBtn.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
    }
}


extension EditProfileVC: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        
        for result in results {
            result.itemProvider.loadObject(ofClass: UIImage.self) { object, error in
                if error != nil {
                    return
                }
                
                guard let image = object as? UIImage else {
                    return
                }
                DispatchQueue.main.async {
                    self.profileImageView.image = image
                }
            }
        }
    }
    
}
