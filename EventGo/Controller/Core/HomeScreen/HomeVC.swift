//
//  HomeVC.swift
//  EventGo
//
//  Created by Abdulkerim Can on 10.10.2023.
//

import UIKit
import SnapKit
import RxSwift
import RxDataSources

protocol HomeVCDelegate: AnyObject {
    func configureVC()
    func reloadData()
    func navigateToDetail(with event: Event)
    func bindCollectionView()
}

final class HomeVC: UIViewController, UICollectionViewDelegateFlowLayout {
    private let disposeBag = DisposeBag()
    private lazy var viewModel = HomeViewModel()
    private var collectionView: UICollectionView!
    
    private var searchController = UISearchController(searchResultsController: SearchVC())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
     func bindCollectionView() {
        collectionView = UICollectionView(frame: .zero,
                                           collectionViewLayout: createHomeCompositionalLayout(viewModel: viewModel))
         
         view.addSubview(collectionView)
         
         collectionView.snp.makeConstraints { make in
             make.left.right.top.bottom.equalToSuperview()
         }
         collectionView.register(EventCollectionViewCell.self, forCellWithReuseIdentifier: EventCollectionViewCell.identifier)
         collectionView.register(FeaturedCollectionViewCell.self, forCellWithReuseIdentifier: FeaturedCollectionViewCell.identifier)
         collectionView.register(HomeScreenEventCollectionViewCell.self, forCellWithReuseIdentifier: HomeScreenEventCollectionViewCell.identifier)
         collectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier)
         

         let dataSource = RxCollectionViewSectionedReloadDataSource<EventSectionModel> { dataSource, collectionView, indexPath, item in
             let section = self.viewModel.eventList.value[indexPath.section].sectionName
             
             switch section {
             case .featured:
                 guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeaturedCollectionViewCell.identifier, for: indexPath)
                        as? FeaturedCollectionViewCell else {
                     fatalError()
                 }
                 
                 cell.configureCell(event: item)
                 
                 return cell
                 
             default:
                 
                 guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeScreenEventCollectionViewCell.identifier, for: indexPath)
                        as? HomeScreenEventCollectionViewCell else {
                     fatalError()
                 }
                 cell.configureCell(event: item)
                 return cell
             }
         } configureSupplementaryView: { dataSource, collectionView, title, indexPath in
             guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier, for: indexPath) as? HeaderCollectionReusableView else {
                                 fatalError()
                             }
                             let title = self.viewModel.eventList.value[indexPath.section].sectionName.rawValue
                             header.setTitle(title: title)
                             return header
         }
         
         viewModel
             .eventList
             .bind(to: collectionView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
         
         collectionView.rx.itemSelected.bind { indexPath in
             self.viewModel.getEvent(indexPath: indexPath)
         }.disposed(by: disposeBag)
    }
}

extension HomeVC: HomeVCDelegate {
    func navigateToDetail(with event: Event) {
        DispatchQueue.main.async {
            let vc = EventDetailVC(event: event)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func configureVC() {
        title = "Home"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.setRightBarButtonItems([UIBarButtonItem(image: UIImage(systemName: "bookmark.fill"),
                                                               style: .done,
                                                               target: self,
                                                               action: nil),
                                               UIBarButtonItem(image: UIImage(systemName: "bell.fill"),
                                                               style: .done,
                                                               target: self,
                                                               action: nil)],
                                              animated: true)
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
    }
}

extension HomeVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let vc = searchController.searchResultsController as? SearchVC else {
            return
        }
        
        searchController
            .searchBar
            .rx
            .text
            .orEmpty
            .debounce(.milliseconds(500),
                      scheduler: MainScheduler.instance)
            .subscribe { query in
                vc.viewModel.search(searchText: query, events: self.viewModel.eventList.value)
            }.disposed(by: disposeBag)
    }
}

