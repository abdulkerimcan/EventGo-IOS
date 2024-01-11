//
//  HomeCollectionViewHelper.swift
//  EventGo
//
//  Created by Abdulkerim Can on 11.10.2023.
//

import UIKit

extension UIViewController {
    func createHomeCompositionalLayout(viewModel: HomeViewModel) -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout{sectionIndex,_ in
            return self.createHomeSection(viewModel: viewModel,for: sectionIndex)
        }
        return layout
    }
    
    private func createHomeSection(viewModel: HomeViewModel, for sectionIndex: Int) -> NSCollectionLayoutSection {
        let section = viewModel.eventList.value[sectionIndex].sectionName
        
        switch section {
        case .featured:
            return createFeaturedSectionLayout()
        default:
            return createEventSectionLayout()
        }
    }
    
    private func createFeaturedSectionLayout() -> NSCollectionLayoutSection{
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)))
        
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 10,
            leading: 5,
            bottom: 10,
            trailing: 8)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(200)),
            subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 10)
        section.boundarySupplementaryItems = [suplementaryHeaderItem()]
        return section
    }
    
    private func createEventSectionLayout() -> NSCollectionLayoutSection{
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)))
        
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 10,
            leading: 5,
            bottom: 10,
            trailing: 8)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.6),
                heightDimension: .absolute(250)),
            subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 10)
        section.boundarySupplementaryItems = [suplementaryHeaderItem()]
        return section
    }
    
    private func suplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
    }
}

