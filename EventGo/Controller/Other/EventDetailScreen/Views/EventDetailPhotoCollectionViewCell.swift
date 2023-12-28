//
//  EventDetailPhotoCollectionViewCell.swift
//  EventGo
//
//  Created by Abdulkerim Can on 29.12.2023.
//

import UIKit
import SnapKit
import Kingfisher

final class EventDetailPhotoCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "EventDetailPhotoCollectionViewCell"
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        return imageView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
    func configureImage(urlString: String) {
        let url = URL(string: urlString)
        imageView.kf.setImage(with: url)
    }
}

