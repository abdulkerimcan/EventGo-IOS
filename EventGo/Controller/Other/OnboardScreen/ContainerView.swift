//
//  ContainerView.swift
//  EventGo
//
//  Created by Abdulkerim Can on 10.10.2023.
//

import UIKit
import SnapKit

final class ContainerView: UIView {
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = UIColor(named: "mainColor")
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .label
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl(frame: .zero)
        pageControl.numberOfPages = 3
        pageControl.currentPageIndicatorTintColor = UIColor(named: "mainColor")
        return pageControl
    }()
    
    let skipBtn = CustomButton(title: "Skip", hasBackground: false, fontSize: .large)
    
    let nextBtn = CustomButton(title: "Next", hasBackground: true, fontSize: .large)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        backgroundColor = UIColor(named: "secondaryMainColor")
        addSubviews(headerLabel,subtitleLabel,pageControl,skipBtn,nextBtn)
        layer.cornerRadius = 20
        
        headerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            
            make.top.equalTo(headerLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
        }
        
        skipBtn.snp.makeConstraints { make in
            make.top.equalTo(pageControl.snp.bottom).offset(20)
            make.right.equalToSuperview().offset(-20)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(50)
        }
        
        nextBtn.snp.makeConstraints { make in
            make.left.right.equalTo(skipBtn)
            make.top.equalTo(skipBtn.snp.bottom).offset(20)
            make.height.equalTo(50)
        }
    }
    
    func configureContainer(onboardModel: OnBoardModel,selectedIndex: Int) {
        headerLabel.text = onboardModel.title
        subtitleLabel.text = onboardModel.subtitle
        pageControl.currentPage = selectedIndex
    }
}
