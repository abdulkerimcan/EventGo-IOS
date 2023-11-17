//
//  EditProfileVC.swift
//  EventGo
//
//  Created by Abdulkerim Can on 20.10.2023.
//

import UIKit
import SnapKit
import iOSDropDown
import Kingfisher
import PhotosUI

protocol EditProfileVCDelegate: AnyObject, AlertPresentable {
    func configureVC(with user: User?)
    func configureProfileImageView(with image: String)
    func configureDivider()
    func configureStackView()
    func configureTextfield()
    func configureDateOfBirth()
    func configureDropDown()
    func configureSaveChangesBtn()
    func configureSpinner()
    func startSpinner()
    func stopSpinner()
    func navigateBack()
    
}

final class EditProfileVC: UIViewController {
    
    private var profileImageView: UIImageView!
    
    private lazy var editImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(systemName: "pencil")
        imageview.tintColor = UIColor(named: "mainColor")
        return imageview
    }()
    
    private lazy var stackview: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 30
        return stack
    }()
    
    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        spinner.style = .large
        return spinner
    }()
    
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
    
    private lazy var dateOfBirthTF = CustomTextField(placeHolder: "Date of Birth")
    
    private lazy var dropDown: GenderDropDown = {
        let gender = GenderDropDown(frame: .zero)
        return gender
    }()
    
    private lazy var saveChangesBtn = CustomButton(title: "Save Changes", hasBackground: true, fontSize: .large)
    
    private lazy var divider: UIView = {
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
    
    @objc private func didTapSaveChangesButton() {
        guard let fullname = fullNameTF.text, !fullname.isEmpty else {
            showAlert(title: "Error", message: "Fullname cannot be empty") {
                
            }
            return
        }
        guard let gender = dropDown.text, !gender.isEmpty else {
            showAlert(title: "Error", message: "Gender cannot be empty") {
                
            }
            return
        }
        
        guard let birthday = dateOfBirthTF.text else {
            showAlert(title: "Error", message: "Birthday cannot be empty") {
                
            }
            return
        }
        
        viewModel.didTapSaveChangesButton(fullname: fullname, gender: gender, birthday: birthday,imageData: profileImageView.image?.jpegData(compressionQuality: 0.8))
    }
}

extension EditProfileVC: EditProfileVCDelegate {
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
        stackview.alpha = 0.5
    }
    
    func stopSpinner() {
        
        spinner.stopAnimating()
        stackview.alpha = 1
    }
    
    func navigateBack() {
        DispatchQueue.main.async {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    
    func configureVC(with user: User?) {
        title = "Edit Profile"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = UIColor(named: "secondaryMainColor")
        guard let user = user else {
            return
        }
        fullNameTF.text = user.fullname
        dropDown.text = user.gender
        dateOfBirthTF.text = user.dateOfBirth
    }
    
    func configureProfileImageView(with image: String) {
        
        profileImageView = UIImageView(frame: .init(x: 0, y: 0, width: 150, height: 150))
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.clipsToBounds = true
        stackview.addArrangedSubview(profileImageView)
        
        profileImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(150)
            make.width.equalTo(150)
        }
        let url = URL(string: image)
        
        profileImageView.kf.setImage(
            with: url,
            placeholder: UIImage(systemName: "person"),
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(0.2)),
                .cacheOriginalImage
            ])
        
        profileImageView.tintColor = .black
        profileImageView.makeRounded()
        
        profileImageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapProfileImageView))
        profileImageView.addGestureRecognizer(gestureRecognizer)
        
    }
    
    func configureDivider() {
        
        stackview.addArrangedSubview(divider)
        
        divider.snp.makeConstraints { make in
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
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
        }
    }
    
    func configureTextfield() {
        
        stackview.addArrangedSubview(fullNameTF)
        
        fullNameTF.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.left.equalToSuperview().offset(10)
        }
        
    }
    
    func configureDropDown() {
        stackview.addArrangedSubview(dropDown)
        
        dropDown.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.left.equalToSuperview().offset(10)
        }
    }
    
    func configureDateOfBirth() {
        stackview.addArrangedSubview(dateOfBirthTF)
        
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
        
        
        dateOfBirthTF.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.left.equalToSuperview().offset(10)
        }
        
    }
    
    func configureSaveChangesBtn() {
        
        stackview.addArrangedSubview(saveChangesBtn)
        
        saveChangesBtn.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.left.equalToSuperview().offset(10)
        }
        saveChangesBtn.addTarget(self, action: #selector(didTapSaveChangesButton), for: .touchUpInside)
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

