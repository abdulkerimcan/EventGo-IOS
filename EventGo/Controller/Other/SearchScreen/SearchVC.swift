//
//  SearchVC.swift
//  EventGo
//
//  Created by Abdulkerim Can on 31.12.2023.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

protocol SearchVCDelegate: AnyObject {
    func configureCollectionView()
    func navigateToDetail(with event: Event)
    func reloadData()
}

final class SearchVC: UIViewController {
    private let disposeBag = DisposeBag()
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        return collectionView
    }()
    
    
    lazy var viewModel = SearchViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
}

extension SearchVC: SearchVCDelegate {
    func navigateToDetail(with event: Event) {
        DispatchQueue.main.async {
            let vc = EventDetailVC(event: event)
            self.present(vc, animated: true)
            
        }
    }
    
    func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.left.right.bottom.top.equalToSuperview()
        }
        collectionView.register(EventCollectionViewCell.self, forCellWithReuseIdentifier: EventCollectionViewCell.identifier)
        
        viewModel.eventList.bind(to: collectionView.rx.items(cellIdentifier: EventCollectionViewCell.identifier, cellType: EventCollectionViewCell.self)) {
            index, event, cell in
            cell.configureCell(with: event)
        }
        
        collectionView.rx.itemSelected.bind { indexPath in
            self.viewModel.getEvent(indexPath: indexPath)
        }
        
    }
    func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
