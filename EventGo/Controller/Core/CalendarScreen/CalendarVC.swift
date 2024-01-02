//
//  CalendarVC.swift
//  EventGo
//
//  Created by Abdulkerim Can on 11.10.2023.
//

import UIKit
import SnapKit

protocol CalendarVCDelegate: AnyObject {
    func configureVC()
    func configureDatePicker()
    func configureCollectionView()
    func reloadDate()
}

final class CalendarVC: UIViewController {
     
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .inline
        datePicker.calendar = .current
        datePicker.minimumDate = .now
        datePicker.datePickerMode = .date
        return datePicker
    }()
    
    private var collectionview: UICollectionView!
    
    private lazy var viewModel = CalendarViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
    //MARK: Selecter Methods
    @objc func onDateValueChange(_ datePicker: UIDatePicker) {
        viewModel.fetchEvents(date: datePicker.date)
    }
}

extension CalendarVC: CalendarVCDelegate {
    
    func configureVC() {
        title = "Calendar"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureDatePicker() {
        view.addSubview(datePicker)
        datePicker.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        datePicker.addTarget(self, action: #selector(onDateValueChange(_:)) , for: .valueChanged)
        
    }
    
    func configureCollectionView() {
        
        collectionview = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        
        view.addSubview(collectionview)
        
        collectionview.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(datePicker.snp.bottom).offset(10)
            
            
        }
        
        collectionview.backgroundColor = .secondaryMain
        collectionview.delegate = self
        collectionview.dataSource = self
        
        collectionview.register(EventCollectionViewCell.self, forCellWithReuseIdentifier: EventCollectionViewCell.identifier)
        collectionview.register(CalendarEventsHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CalendarEventsHeaderCollectionReusableView.identifier)
    }
    
    func reloadDate() {
        DispatchQueue.main.async {
            self.collectionview.reloadData()
        }
    }
}

extension UIDatePicker {
    func setOnDateChangeListener(onDateChanged :@escaping () -> Void){
        self.addAction(UIAction() { action in
            onDateChanged()
        },for: .valueChanged)
    }
}

extension CalendarVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CalendarEventsHeaderCollectionReusableView.identifier, for: indexPath) as? CalendarEventsHeaderCollectionReusableView else {
            fatalError()
        }
        
        header.configureCalendarEventHeader(with: viewModel.events.count)
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: .dWidth, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.events.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventCollectionViewCell.identifier, for: indexPath) as? EventCollectionViewCell else {
            fatalError()
        }
        
        cell.configureCell(with: viewModel.events[indexPath.item])
        
        return cell
    }
}

