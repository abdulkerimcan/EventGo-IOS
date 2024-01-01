//
//  HomeVC.swift
//  EventGo
//
//  Created by Abdulkerim Can on 10.10.2023.
//

import UIKit
import SnapKit

protocol HomeVCDelegate: AnyObject {
    func configureCollectionView()
    func configureVC()
    func reloadData()
    func navigateToDetail(with event: Event)
    
}

final class HomeVC: UIViewController {
    
    private lazy var viewModel = HomeViewModel()
    
    private var collectionView: UICollectionView!
    
    private var searchController = UISearchController(searchResultsController: SearchVC())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.view = self
        viewModel.viewDidLoad()
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
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: createHomeCompositionalLayout(viewModel: viewModel))
        
        
        view.addSubview(collectionView)
        collectionView.backgroundColor = .secondaryMain
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(FeaturedCollectionViewCell.self, forCellWithReuseIdentifier: FeaturedCollectionViewCell.identifier)
        collectionView.register(HomeScreenEventCollectionViewCell.self, forCellWithReuseIdentifier: HomeScreenEventCollectionViewCell.identifier)
        collectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier)
        
        collectionView.snp.makeConstraints { make in
            make.left.bottom.top.right.equalToSuperview()
        }
    }
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier, for: indexPath) as! HeaderCollectionReusableView
        
        let sectionType = viewModel.sections[indexPath.section]
        
        header.setTitle(title: sectionType.rawValue)
        return header
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if viewModel.events.isEmpty {
            return 0
        }
        return viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = viewModel.sections[section]
        
        switch section {
        case .featured:
            return viewModel.featuredEvents.count
        case .concert:
            return viewModel.getFilteredEvents(eventType: .concert).count
        case .sport:
            return viewModel.getFilteredEvents(eventType: .sport).count
        case .theatr:
            return viewModel.getFilteredEvents(eventType: .theatr).count
        case .party:
            return viewModel.getFilteredEvents(eventType: .party).count
        case .newest:
            return viewModel.events.count
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        viewModel.getEvent(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = viewModel.sections[indexPath.section]
        
        switch section {
            
        case .featured:
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeaturedCollectionViewCell.identifier, for: indexPath)
                    as? FeaturedCollectionViewCell else {
                fatalError()
            }
            cell.configureCell(event: viewModel.featuredEvents[indexPath.item])
            
            return cell
            
        case .newest:
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeScreenEventCollectionViewCell.identifier, for: indexPath)
                    as? HomeScreenEventCollectionViewCell else {
                fatalError()
            }
            cell.configureCell(event: viewModel.events[indexPath.item])
            
            return cell
            
        default:
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeScreenEventCollectionViewCell.identifier, for: indexPath)
                    as? HomeScreenEventCollectionViewCell else {
                fatalError()
            }
            cell.configureCell(event: viewModel.getFilteredEvents(eventType: section)[indexPath.item])
            
            return cell
        }
    }
}

extension HomeVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let vc = searchController.searchResultsController as? SearchVC else {
            return
        }
        vc.viewModel.search(searchText: searchController.searchBar.text, events: viewModel.events)
    }
}

