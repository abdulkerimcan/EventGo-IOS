//
//  ProfileVC.swift
//  EventGo
//
//  Created by Abdulkerim Can on 11.10.2023.
//

import UIKit
import SnapKit
import Kingfisher

protocol ProfileVCDelegate: AnyObject {
    func configureFollowingSection()
    func configureVC()
    func configureProfileImage()
    func configureAboutSection()
    func navigateToSettings()
    func prepareVC(with user: User?)
    func prepareProfileImage(with image: String)
}

final class ProfileVC: UIViewController {
    
    private var profileImageView: UIImageView!
    
    private let profileFullNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.text = "Maclovin"
        return label
    }()
    
    private let horizontalStackview: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.spacing = 40
        stackview.alignment = .center
        return stackview
    }()
    
    private let followersVerticalStackview: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.alignment = .center
        return stackview
    }()
    
    private let followingVerticalStackview: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.alignment = .center
        return stackview
    }()
    
    
    private let eventsVerticalStackview: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.alignment = .center
        return stackview
    }()
    
    
    private let followersCountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private let followersLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .thin)
        label.text = "Followers"
        return label
    }()
    
    private let followingCountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private let followingLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .thin)
        label.text = "Following"
        return label
    }()
    
    private let eventsCountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private let eventsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .thin)
        label.text = "Events"
        return label
    }()
    
    private let divider: UIView = {
        let divider = UIView()
        divider.backgroundColor = .tertiarySystemBackground
        return divider
    }()
    
    private let aboutLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.text = "About"
        return label
    }()
    
    private let aboutMultiLineLabel:  UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .thin)
        label.numberOfLines = 0
        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        return label
    }()
    
    private lazy var viewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.view = self
        viewModel.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }
    
    //MARK: Selector Methods
    @objc private func didTapSettings() {
        navigateToSettings()
    }
}

extension ProfileVC: ProfileVCDelegate {
    func configureProfileImage() {
        profileImageView = UIImageView(frame: .init(x: 0, y: 0, width: 100, height: 100))
        view.addSubview(profileImageView)
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.height.equalTo(100)
            make.width.equalTo(100)
            make.centerX.equalToSuperview()
        }
        
        profileImageView.makeRounded()
    }
    
    func configureVC() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(didTapSettings))
    }
    
    
    func navigateToSettings() {
        DispatchQueue.main.async {
            let vc = SettingsVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func prepareVC(with user: User?) {
        guard let user = user else {
            return
        }
        profileFullNameLabel.text = user.fullname
        followersCountLabel.text = "\(user.followers.count)"
        followingCountLabel.text = "\(user.followings.count)"
        eventsCountLabel.text = "\(user.events.count)"
    }
    
    func configureAboutSection() {
        view.addSubviews(aboutLabel,
                         aboutMultiLineLabel)
        
        aboutLabel.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.top.equalTo(divider.snp.bottom).offset(20)
        }
        
        aboutMultiLineLabel.snp.makeConstraints { make in
            make.left.equalTo(aboutLabel)
            make.top.equalTo(aboutLabel.snp.bottom).offset(5)
            make.right.equalToSuperview().offset(-10)
        }
    }
    
    func configureFollowingSection() {
        view.addSubviews(horizontalStackview,
                         profileFullNameLabel,
                         divider)
        
        profileFullNameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(profileImageView.snp.bottom).offset(20)
        }
        
        horizontalStackview.addArrangedSubview(followersVerticalStackview)
        horizontalStackview.addArrangedSubview(followingVerticalStackview)
        horizontalStackview.addArrangedSubview(eventsVerticalStackview)
        
        horizontalStackview.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(profileFullNameLabel.snp.bottom).offset(20)
        }
        
        followersVerticalStackview.addArrangedSubview(followersCountLabel)
        followersVerticalStackview.addArrangedSubview(followersLabel)
        
        followingVerticalStackview.addArrangedSubview(followingCountLabel)
        followingVerticalStackview.addArrangedSubview(followingLabel)
        
        eventsVerticalStackview.addArrangedSubview(eventsCountLabel)
        eventsVerticalStackview.addArrangedSubview(eventsLabel)
        
        divider.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(1)
            make.top.equalTo(horizontalStackview.snp.bottom).offset(20)
        }
    }
    
    func prepareProfileImage(with image: String) {
        
        let url = URL(string: image)
        
        profileImageView.kf.setImage(with: url,
                                     placeholder: UIImage(systemName: "person"))
        
    }
}
