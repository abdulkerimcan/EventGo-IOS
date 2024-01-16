//
//  CalendarVC.swift
//  EventGo
//
//  Created by Abdulkerim Can on 11.10.2023.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

protocol CalendarVCDelegate: AnyObject {
    func configureVC()
    func configureDatePicker()
    func bindCollectionView()
    func navigateToDetail(with event: Event)
    func reloadDate()
}

final class CalendarVC: UIViewController {
     
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .inline
        datePicker.calendar = .current
        datePicker.minimumDate = .now
        datePicker.datePickerMode = .date
        return datePicker
    }()
    
    private lazy var collectionview = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    private lazy var viewModel = CalendarViewModel()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    //MARK: Selecter Methods
    @objc func onDateValueChange(_ datePicker: UIDatePicker) {
        viewModel.fetchEvents(date: datePicker.date)
    }
}

extension CalendarVC: CalendarVCDelegate {
    
    func navigateToDetail(with event: Event) {
        DispatchQueue.main.async {
            let vc = EventDetailVC(event: event)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func bindCollectionView() {
        collectionview.backgroundColor = .secondaryMain
        view.addSubview(collectionview)
        
        collectionview.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(datePicker.snp.bottom).offset(10)
        }
        
        collectionview.register(EventCollectionViewCell.self, forCellWithReuseIdentifier: EventCollectionViewCell.identifier)
        
        viewModel.eventList.bind(to: collectionview
            .rx
            .items(cellIdentifier: EventCollectionViewCell.identifier, cellType: EventCollectionViewCell.self)) {
                index, event, cell in
                cell.configureCell(with: event)
            }.disposed(by: disposeBag)
        
        collectionview
            .rx
            .itemSelected
            .bind { indexPath in
                self.viewModel.getEvent(indexPath: indexPath)
            }.disposed(by: disposeBag)
        
    }

    
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

