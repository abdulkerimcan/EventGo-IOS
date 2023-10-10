//
//  OnboardVC.swift
//  EventGo
//
//  Created by Abdulkerim Can on 10.10.2023.
//

import UIKit
import SnapKit

protocol OnboardVCDelegate: AnyObject {
    func configureContainer()
    func updateUI(model: OnBoardModel)
    func navigateToLoginScreen()
}

final class OnboardVC: UIViewController {
    
    private let imageView: UIImageView = {
        let imageview = UIImageView(frame: .zero)
        imageview.image = UIImage(named: "onboard1")
        imageview.contentMode = .scaleAspectFill
        return imageview
    }()
    
    private var containerView = ContainerView(frame: .zero)
    
    private lazy var viewModel = OnboardViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
        
    }
    
    @objc func didTapSkipBtn() {
        viewModel.didTapSkip()
    }
    
    @objc func didTapNextBtn() {
        viewModel.didTapNext()
    }
}

extension OnboardVC: OnboardVCDelegate {
    
    func navigateToLoginScreen() {
        let loginVC = LoginVC()
        loginVC.modalPresentationStyle = .fullScreen
        loginVC.modalTransitionStyle = .flipHorizontal
        present(loginVC, animated: true, completion: nil)
    }
    
    func updateUI(model: OnBoardModel) {
        DispatchQueue.main.async {
            let image = UIImage(named: model.image)
            self.imageView.image = image
            self.containerView.configureContainer(onboardModel: model,selectedIndex: self.viewModel.selectedIndex)
        }
    }
    
    func configureContainer() {
        
        view.addSubviews(imageView,containerView)
        
        let index = viewModel.selectedIndex
        containerView.configureContainer(onboardModel: viewModel.onboardElements[index],selectedIndex: viewModel.selectedIndex)
        imageView.snp.makeConstraints { make in
            make.height.equalTo(CGFloat.dHeight * 0.6)
            make.width.equalTo(CGFloat.dWidth)
            make.top.left.right.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.width.equalTo(CGFloat.dWidth)
            make.height.equalTo(CGFloat.dHeight * 0.5)
        }
        containerView.nextBtn.addTarget(self, action: #selector(didTapNextBtn), for: .touchUpInside)
        containerView.skipBtn.addTarget(self, action: #selector(didTapSkipBtn), for: .touchUpInside)
    }
}
