//
//  CreateEventVC.swift
//  EventGo
//
//  Created by Abdulkerim Can on 12.10.2023.
//

import UIKit
import SnapKit
import PhotosUI
import iOSDropDown
import MapKit

protocol CreateEventVCDelegate: AnyObject {
    func configureVC()
    func configureCoverView()
    func configureEventName()
    func configureEventType()
    func configureDatePicker()
    func configureTimePicker()
    func configureEventPrice()
    func configureMapView()
    func configureCreateEventButton()
    func navigateToTabVC()
}

final class CreateEventVC: UIViewController {
    
    private let scrollView = UIScrollView()
    
    private let stackview: UIStackView = {
        let stackview = UIStackView()
        stackview.spacing = 20
        stackview.axis = .vertical
        return stackview
    }()
    
    private let coverView: CoverView = {
        let container = CoverView()
        return container
    }()
    
    private let divider: UIView = {
        let divider = UIView()
        divider.backgroundColor = .gray
        return divider
    }()
    
    private let eventDetailsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.text = "Event Details"
        return label
    }()
    
    private let eventNameTF = CustomTextField(placeHolder: "Event Name")
    
    private let dropDown: CustomDropDown = {
        let dropdown = CustomDropDown()
        dropdown.optionArray = ["Music","Theatr","Cinema","Concert"]
        dropdown.placeholder = "Select Type"
        return dropdown
    }()
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.minimumDate = .now
        datePicker.preferredDatePickerStyle = .inline
        return datePicker
    }()
    
    private let eventDateTF = CustomTextField(placeHolder: "Select Date")
    
    private let timePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .wheels
        return datePicker
    }()
    
    private let eventTimeTF = CustomTextField(placeHolder: "Select Hour")
    
    private let eventPriceTF = CustomTextField(placeHolder: "Select Price")
    
    private let eventLocationTF = CustomTextField(placeHolder: "Select Location")
    
    private let mapview: MKMapView = {
        let mapview = MKMapView()
        mapview.layer.cornerRadius = 10
        return mapview
    }()
    
    private let createEventBtn = CustomButton(title: "Create New Event & Publish", hasBackground: true, fontSize: .medium)
    
    private var coordinateTuple = (latitude: 0.0,longitude: 0.0)
    private var locationManager: CLLocationManager?
    private var geocoder = CLGeocoder()
    private lazy var viewModel = CreateEventViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
    //MARK: Selector Methods
    @objc private func didTapAddPhoto() {
        var config = PHPickerConfiguration()
        config.selectionLimit = 1
        let phPickerVC = PHPickerViewController(configuration: config)
        phPickerVC.delegate = self
        present(phPickerVC, animated: true)
        
    }
    
    @objc private func didTapDateDoneBtn() {
        let dateString = viewModel.didTapDateDoneBtn(date: datePicker.date)
        eventDateTF.text = dateString
        view.endEditing(true)
    }
    
    @objc private func didTapTimeDoneBtn() {
        let dateString = viewModel.didTapTimeDoneBtn(date: timePicker.date)
        eventTimeTF.text = dateString
        view.endEditing(true)
    }
    
    @objc private func didLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        
        if gestureRecognizer.state != UIGestureRecognizer.State.ended{
            
            let allAnnotations = mapview.annotations
            mapview.removeAnnotations(allAnnotations)
            let touchLocation = gestureRecognizer.location(in: mapview)
            let locationCoordinate = mapview.convert(touchLocation, toCoordinateFrom: mapview)
            let pin = MKPointAnnotation()
            pin.coordinate = locationCoordinate
            mapview.addAnnotation(pin)
            
            let clLocation = CLLocation(latitude: locationCoordinate.latitude, longitude: locationCoordinate.longitude)
            coordinateTuple.latitude = locationCoordinate.latitude
            coordinateTuple.longitude = locationCoordinate.longitude
            
            geocoder.reverseGeocodeLocation(clLocation) { placemarks, error in
                if error != nil {
                    return
                }
                let placemark = placemarks?.first
                self.eventLocationTF.text = placemark?.name
            }
        }
        
        if gestureRecognizer.state != UIGestureRecognizer.State.began {
            return
        }
    }
    
    @objc private func didTapcreateEventBtn() {
       guard let coverImageView = coverView.coverImageView.image else {
           AlertManager.shared.showBasicAlert(title: "Empty Event image", message: "Event image cannot be empty", on: self)
           return
       }
                
        guard let eventNameText = eventNameTF.text,
              !eventNameText.isEmpty else {
            AlertManager.shared.showBasicAlert(title: "Empty Event Name", message: "Event Name cannot be empty", on: self)
            return
        }
        
        guard let eventTypeText = dropDown.text,
              !eventTypeText.isEmpty else {
            AlertManager.shared.showBasicAlert(title: "Empty Event Type", message: "Event Type cannot be empty", on: self)
            return
        }
        
        guard let eventDateText = eventDateTF.text,
              !eventDateText.isEmpty else {
            AlertManager.shared.showBasicAlert(title: "Empty Event Date", message: "Event Date cannot be empty", on: self)
            return
        }
        
        guard let eventTimeText = eventTimeTF.text,
              !eventTimeText.isEmpty else {
            AlertManager.shared.showBasicAlert(title: "Empty Event Time", message: "Event Time cannot be empty", on: self)
            return
        }
        
        guard let eventPriceText = eventPriceTF.text,
              !eventPriceText.isEmpty else {
            AlertManager.shared.showBasicAlert(title: "Empty Event Price", message: "Event Price cannot be empty", on: self)
            return
        }
        
        guard let eventLocationText = eventLocationTF.text,
              !eventLocationText.isEmpty else {
            AlertManager.shared.showBasicAlert(title: "Empty Event Location", message: "Event Location cannot be empty", on: self)
            return
        }
        viewModel.postEvent(eventNameText: eventNameText,
                            eventTypeText: eventTypeText,
                            eventDateText: eventDateText,
                            eventTimeText: eventTimeText,
                            eventPriceText: eventPriceText,
                            eventLocationText: eventLocationText,
                            eventCoordinateTuple: coordinateTuple,
                            imageData: coverImageView.jpegData(compressionQuality: 0.5))
        
        
    }
    
}

extension CreateEventVC: CreateEventVCDelegate {
    
    func configureVC() {
        title = "Create New Event"
        view.backgroundColor = UIColor(named: "secondaryMainColor")
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
            make.width.equalTo(CGFloat.dWidth)
        }
        scrollView.addSubview(stackview)
        stackview.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(scrollView)
            make.width.equalTo(CGFloat.dWidth)
        }
    }
    
    func configureCoverView() {
        stackview.addArrangedSubview(coverView)
        
        coverView.snp.makeConstraints { make in
            make.left.equalTo(scrollView).offset(20)
            make.right.equalTo(scrollView).offset(-20)
            make.top.equalToSuperview().offset((navigationController?.navigationBar.frame.height ?? 0))
            make.height.equalTo(CGFloat.dHeight * 0.2)
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapAddPhoto))
        coverView.isUserInteractionEnabled = true
        coverView.addGestureRecognizer(tap)
        
        stackview.addArrangedSubview(divider)
        divider.snp.makeConstraints { make in
            make.top.equalTo(coverView.snp.bottom).offset(20)
            make.height.equalTo(0.5)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        stackview.addArrangedSubview(eventDetailsLabel)
        eventDetailsLabel.snp.makeConstraints { make in
            make.top.equalTo(divider.snp.bottom).offset(20)
            make.left.right.equalTo(divider)
        }
        
    }
    
    func configureEventName() {
        stackview.addArrangedSubview(eventNameTF)

        eventNameTF.snp.makeConstraints { make in
            make.top.equalTo(eventDetailsLabel.snp.bottom).offset(20)
            make.left.right.equalTo(divider)
            make.height.equalTo(50)
        }
    }
    
    func configureEventType() {
        stackview.addArrangedSubview(dropDown)
        dropDown.isSearchEnable = false
        
        dropDown.snp.makeConstraints { make in
            make.top.equalTo(eventNameTF.snp.bottom).offset(20)
            make.height.equalTo(50)
            make.left.right.equalTo(eventNameTF)
            make.width.equalTo(CGFloat.dWidth)
        }
        
        dropDown.optionArray = viewModel.eventTypes.compactMap({ EventType in
            EventType.rawValue
        })
        
        dropDown.didSelect { selectedText, index, id in
            self.dropDown.text = selectedText
        }
        
    }
    
    func configureDatePicker() {
        stackview.addArrangedSubview(eventDateTF)
        let dateToolbar = UIToolbar()
        dateToolbar.sizeToFit()
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapDateDoneBtn))
        dateToolbar.setItems([doneBtn], animated: true)
        
        eventDateTF.snp.makeConstraints { make in
            make.top.equalTo(dropDown.snp.bottom).offset(20)
            make.left.right.equalTo(dropDown)
            make.height.equalTo(50)
        }
        let dateImageView = UIImageView(image: UIImage(systemName: "calendar"))
        dateImageView.tintColor = .label
        eventDateTF.rightView = dateImageView
        eventDateTF.rightViewMode = .always
        eventDateTF.inputView = datePicker
        eventDateTF.inputAccessoryView = dateToolbar
    }
    
    func configureTimePicker() {
        stackview.addArrangedSubview(eventTimeTF)
        eventTimeTF.snp.makeConstraints { make in
            make.top.equalTo(eventDateTF.snp.bottom).offset(20)
            make.left.right.equalTo(eventDateTF)
            make.height.equalTo(50)
        }
        
        let timeToolbar = UIToolbar()
        timeToolbar.sizeToFit()
        let timeDoneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapTimeDoneBtn))
        timeToolbar.setItems([timeDoneBtn], animated: true)
        
        let hourImageView = UIImageView(image: UIImage(systemName: "clock"))
        hourImageView.tintColor = .label
        eventTimeTF.rightView = hourImageView
        eventTimeTF.rightViewMode = .always
        eventTimeTF.inputView = timePicker
        eventTimeTF.inputAccessoryView = timeToolbar
    }
    
    func configureEventPrice() {
        stackview.addArrangedSubview(eventPriceTF)
        eventPriceTF.textContentType = .telephoneNumber
        eventPriceTF.delegate = self
        eventPriceTF.keyboardType = .decimalPad
        eventPriceTF.snp.makeConstraints { make in
            make.top.equalTo(eventTimeTF.snp.bottom).offset(20)
            make.left.right.equalTo(eventTimeTF)
            make.height.equalTo(50)
        }
    }
    
    func configureMapView() {
        stackview.addArrangedSubview(eventLocationTF)
        eventLocationTF.isEnabled = false
        eventLocationTF.snp.makeConstraints { make in
            make.top.equalTo(eventPriceTF.snp.bottom).offset(20)
            make.left.right.equalTo(eventPriceTF)
            make.height.equalTo(50)
        }
        stackview.addArrangedSubview(mapview)
        mapview.snp.makeConstraints { make in
            make.top.equalTo(eventLocationTF.snp.bottom).offset(20)
            make.left.right.equalTo(eventLocationTF)
            make.height.equalTo(CGFloat.dHeight * 0.2)
        }
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.requestLocation()
        
        let longTapGesture = UILongPressGestureRecognizer(target: self, action: #selector(didLongPress))
        mapview.addGestureRecognizer(longTapGesture)
    }
    
    func configureCreateEventButton() {
        stackview.addArrangedSubview(createEventBtn)
        createEventBtn.snp.makeConstraints { make in
            make.top.equalTo(mapview.snp.bottom).offset(20)
            make.left.right.equalTo(mapview)
            make.height.equalTo(50)
        }
        createEventBtn.addTarget(self, action: #selector(didTapcreateEventBtn), for: .touchUpInside)
    }
    
    func navigateToTabVC() {
        DispatchQueue.main.async {
            let tabbarVc = TabbarVC()
            tabbarVc.modalPresentationStyle = .fullScreen
            tabbarVc.modalTransitionStyle = .coverVertical
            self.present(tabbarVc, animated: true)
        }
    }
}

extension CreateEventVC: PHPickerViewControllerDelegate {
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
                self.coverView.configureImageView(image: image)
            }
        }
    }
}

extension CreateEventVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        guard let locationManager = locationManager,let location = locationManager.location else {return}
        
        switch locationManager.authorizationStatus {
            
        case .notDetermined,.restricted:
            print("location cannot be determined or restricted")
            mapview.showsUserLocation = false
        case .denied:
            print("location permission has been denied")
            mapview.showsUserLocation = false
        case .authorizedWhenInUse,.authorizedAlways:
            let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
            mapview.setRegion(region, animated: true)
            mapview.showsUserLocation = true
        @unknown default:
            print("Unknown error")
            mapview.showsUserLocation = false
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

extension CreateEventVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if eventPriceTF == textField {
            let allowedCharacters = "0123456789"
            let allowedCharactersSet = CharacterSet(charactersIn: allowedCharacters)
            let typedCharactersSetIn = CharacterSet(charactersIn: string)
            let numbers = allowedCharactersSet.isSuperset(of: typedCharactersSetIn)
            return numbers
        }
        return true
    }
}
