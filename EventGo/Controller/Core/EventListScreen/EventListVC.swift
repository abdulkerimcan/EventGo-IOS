//
//  EventListVC.swift
//  EventGo
//
//  Created by Abdulkerim Can on 11.10.2023.
//

import UIKit
import SnapKit

protocol EventListVCDelegate: AnyObject {
    func configureVC()
    func configureCollectionView()
    func reloadData()
}

final class EventListVC: UIViewController {
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    private lazy var viewModel = EventListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
    @objc private func navigateToCreateEvent() {
        DispatchQueue.main.async {
            let vc = CreateEventVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension EventListVC: EventListVCDelegate {
    func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(EventCollectionViewCell.self,
                                forCellWithReuseIdentifier: EventCollectionViewCell.identifier)
    }
    
    func configureVC() {
        title = "My Events"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create Event",
                                                            style: .done, target: self,
                                                            action: #selector(navigateToCreateEvent))
    }
}

extension EventListVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.events.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventCollectionViewCell.identifier, for: indexPath) as? EventCollectionViewCell else {
            fatalError()
        }
        
        cell.configureCell(with: viewModel.events[indexPath.item])
        
        return cell
    }
}
