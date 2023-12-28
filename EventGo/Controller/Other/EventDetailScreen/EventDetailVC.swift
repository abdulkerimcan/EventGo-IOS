//
//  EventDetailVC.swift
//  EventGo
//
//  Created by Abdulkerim Can on 29.12.2023.
//

import UIKit
import SnapKit
import Kingfisher

protocol EventDetailVCDelegate: AnyObject {
    func configureVC()
    func configureCollectionView()
}

final class EventDetailVC: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createEventDetailCompositionalLayout(viewModel: viewModel))
        return collectionView
    }()
    
    private lazy var viewModel = EventDetailViewModel(event: event)
    
    private let event: Event
    
    init(event: Event) {
        self.event = event
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
}

extension EventDetailVC: EventDetailVCDelegate {
    
    func configureVC() {
        view.backgroundColor = .secondaryMain
    }
    
    func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.backgroundColor = .secondaryMain
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(EventDetailPhotoCollectionViewCell.self, forCellWithReuseIdentifier: EventDetailPhotoCollectionViewCell.identifier)
        collectionView.register(EventDetailInfoCollectionViewCell.self, forCellWithReuseIdentifier: EventDetailInfoCollectionViewCell.identifier)
        
        collectionView.register(EventDetailLocationCollectionViewCell.self, forCellWithReuseIdentifier: EventDetailLocationCollectionViewCell.identifier)
        
        collectionView.register(EventDetailOrganizerCollectionViewCell.self, forCellWithReuseIdentifier: EventDetailOrganizerCollectionViewCell.identifier)
        
        collectionView.snp.makeConstraints { make in
            make.left.top.bottom.right.equalToSuperview()
        }
    }
    
    
}

extension EventDetailVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let collectionViewSection = viewModel.sections[section]
        //Will add gallery photos section here
        switch collectionViewSection {
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = viewModel.sections[indexPath.section]
        
        switch section {
        case .photo:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventDetailPhotoCollectionViewCell.identifier, for: indexPath) as? EventDetailPhotoCollectionViewCell else {
                fatalError()
            }
            cell.configureImage(urlString: event.image ?? "")
            return cell
        case .info:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventDetailInfoCollectionViewCell.identifier, for: indexPath) as? EventDetailInfoCollectionViewCell else {
                fatalError()
            }
            cell.configureCell(with: event)
            return cell
        case .location:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventDetailLocationCollectionViewCell.identifier, for: indexPath) as? EventDetailLocationCollectionViewCell else {
                fatalError()
            }
            cell.configureMap(with: event)
            
            return cell
            
        case .organizer:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventDetailOrganizerCollectionViewCell.identifier, for: indexPath) as? EventDetailOrganizerCollectionViewCell else {
                fatalError()
            }
            viewModel.getOrganizer { user in
                guard let user = user else {
                    return
                }
                cell.configureView(with: user)
            }
            return cell
        }
    }
}

