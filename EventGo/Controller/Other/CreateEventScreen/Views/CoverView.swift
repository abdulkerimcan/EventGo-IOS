//
//  CoverView.swift
//  EventGo
//
//  Created by Abdulkerim Can on 13.10.2023.
//

import UIKit
import SnapKit

final class CoverView: UIView {
    
    private let iconImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(systemName: "plus")
        imageview.tintColor = UIColor(named: "mainColor")
        imageview.layer.frame.size = CGSize(width: 40, height: 40)
        return imageview
    }()
    
    private let addPhotoLabel: UILabel = {
        let label = UILabel()
        label.text = "Add Cover photo"
        return label
    }()
    
     let coverImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.clipsToBounds = true
        imageview.contentMode = .scaleAspectFill
        return imageview
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        layer.cornerRadius = 10
        layer.borderWidth = 0.5
        clipsToBounds = true
        layer.borderColor = UIColor(named: "mainColor")?.cgColor
        
        addSubviews(iconImageView,addPhotoLabel,coverImageView)
        iconImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        addPhotoLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
        
        coverImageView.snp.makeConstraints { make in
            make.left.right.bottom.top.equalToSuperview()
        }
    }
    
    func configureImageView(image: UIImage) {
        DispatchQueue.main.async {
            self.coverImageView.image = image
        }
    }
}
