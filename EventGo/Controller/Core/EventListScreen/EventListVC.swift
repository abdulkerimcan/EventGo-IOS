//
//  EventListVC.swift
//  EventGo
//
//  Created by Abdulkerim Can on 11.10.2023.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

protocol EventListVCDelegate: AnyObject {
    func configureVC()
    func bindCollectionView()
    func navigateToDetail(with: Event)
    func reloadData()
}

final class EventListVC: UIViewController {
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    private lazy var viewModel = EventListViewModel()
    
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
    
    @objc private func navigateToCreateEvent() {
        DispatchQueue.main.async {
            let vc = CreateEventVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension EventListVC: EventListVCDelegate {
    func navigateToDetail(with event: Event) {
        DispatchQueue.main.async {
            let vc = EventDetailVC(event: event)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func bindCollectionView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
        collectionView.register(EventCollectionViewCell.self,
                                forCellWithReuseIdentifier: EventCollectionViewCell.identifier)
        
        viewModel
            .eventList
            .bind(to: collectionView.rx.items(cellIdentifier: EventCollectionViewCell.identifier
                                              , cellType: EventCollectionViewCell.self)) {
                index, event, cell in
                cell.configureCell(with: event)
        }
        .disposed(by: disposeBag)
        
        collectionView.rx.itemSelected.bind { indexPath in
            self.viewModel.getEvent(indexPath: indexPath)
        }.disposed(by: disposeBag)
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func configureVC() {
        title = "My Events"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create Event",
                                                            style: .done, target: self,
                                                            action: #selector(navigateToCreateEvent))
    }
}
