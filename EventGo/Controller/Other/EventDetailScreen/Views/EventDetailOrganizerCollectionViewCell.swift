//
//  EventDetailOrganizerCollectionViewCell.swift
//  EventGo
//
//  Created by Abdulkerim Can on 29.12.2023.
//

import UIKit
import SnapKit
import Kingfisher

final class EventDetailOrganizerCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "EventDetailOrganizerCollectionViewCell"
    
    private lazy var profileImageView: UIImageView = {
        let imageview = UIImageView()
        return imageview
    }()
    
    private lazy var organizerNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private lazy var organizerLabel: UILabel = {
        let label = UILabel()
        label.font = .italicSystemFont(ofSize: 14)
        label.text = "Organizer"
        return label
    }()
    
    private lazy var followBtn = CustomButton(title: "Follow", hasBackground: false, fontSize: .small)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        addSubviews(profileImageView,organizerNameLabel,organizerLabel,followBtn)
        
        profileImageView.snp.makeConstraints { make in
            make.left.top.equalTo(20)
            make.height.width.equalTo(50)
        }
        
        organizerNameLabel.snp.makeConstraints { make in
            make.left.equalTo(profileImageView.snp.right).offset(4)
            make.top.equalTo(profileImageView)
        }
        
        organizerLabel.snp.makeConstraints { make in
            make.left.equalTo(organizerNameLabel)
            make.top.equalTo(organizerNameLabel.snp.bottom).offset(2)
        }
        
        followBtn.snp.makeConstraints { make in
            make.right.equalTo(-20)
            make.top.equalTo(organizerLabel).offset(-2)
        }
    }
    func configureView(with user: User?) {
        let url = URL(string: user?.image ?? "")
        profileImageView.kf.setImage(with: url,placeholder: UIImage(systemName: "person"))
        organizerNameLabel.text = user?.fullname
    }
}

