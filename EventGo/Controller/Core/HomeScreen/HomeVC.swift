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
}

final class HomeVC: UIViewController {
    
    private lazy var viewModel = HomeViewModel()
    
    private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.view = self
        viewModel.viewDidLoad()
    }
}

extension HomeVC: HomeVCDelegate {
    func configureVC() {
        navigationItem.setRightBarButtonItems([UIBarButtonItem(image: UIImage(systemName: "bookmark.fill"), style: .done, target: self, action: nil),
                                               UIBarButtonItem(image: UIImage(systemName: "bell.fill"), style: .done, target: self, action: nil)], animated: true)
        
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: createHomeCompositionalLayout(viewModel: viewModel))
        
        view.addSubview(collectionView)
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
        
        switch sectionType {
        case .featured:
            header.setTitle(title: "Featured")
        case .trending:
            header.setTitle(title: "Trending")
        case .nearby:
            header.setTitle(title: "Nearby Your Location")
        case .newest:
            header.setTitle(title: "Newest Event")
        }
        return header
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.sections.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = viewModel.sections[section]
        
        switch section {
        case .featured:
            return 10
        case .trending:
            return 2
        case .nearby:
            return 10
        case .newest:
            return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = viewModel.sections[indexPath.section]
        
        switch section {
        case .featured:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeaturedCollectionViewCell.identifier, for: indexPath)
                    as? FeaturedCollectionViewCell else {
                fatalError()
            }
            return cell
        case .trending:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeScreenEventCollectionViewCell.identifier, for: indexPath)
                    as? HomeScreenEventCollectionViewCell else {
                fatalError()
            }
            return cell
        case .nearby:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeScreenEventCollectionViewCell.identifier, for: indexPath)
                    as? HomeScreenEventCollectionViewCell else {
                fatalError()
            }
            return cell
        case .newest:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeScreenEventCollectionViewCell.identifier, for: indexPath)
                    as? HomeScreenEventCollectionViewCell else {
                fatalError()
            }
            return cell
        }
    }
}
