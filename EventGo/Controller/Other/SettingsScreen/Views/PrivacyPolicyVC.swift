//
//  PrivacyPolicyVC.swift
//  EventGo
//
//  Created by Abdulkerim Can on 21.10.2023.
//

import UIKit

final class PrivacyPolicyVC: UIViewController {
    
    private let scrollview: UIScrollView = {
        let scrollview = UIScrollView()
        return scrollview
    }()
    
    private let stackview: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()
    
    private let informationTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.text = "1. Information We Collect"
        return label
    }()
    
    private let informationTextLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .thin)
        label.text = "1.1 Personal Information: We may collect personal information such as your name, email address, phone number, and other information you provide when you register for an account or update your profile.\n1.2 Usage Information: We automatically collect certain information when you use the App, including your IP address, device information, browser type, operating system, and usage data. This information helps us improve the App's functionality and user experience."
        label.numberOfLines = 0
        return label
    }()
    
    private let usageTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.text = "2. How We Use Your Information"
        return label
    }()
    
    private let usageTextLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .thin)
        label.text = "2.1 We may use your personal information to:\n*Provide, maintain, and improve the App.\n* Send you important notifications and updates related to the App.\n*Respond to your inquiries and provide customer support.\n*Customize your user experience and personalize the content you see on the App.\n\n*2.2 We may use non-personal information (such as aggregated data) for analytical purposes to improve the App and enhance user satisfaction."
        label.numberOfLines = 0
        return label
    }()
    
    private let sharingTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.text = "3. Sharing Your Information"
        return label
    }()
    
    private let sharingLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .thin)
        label.text = "3.1 We do not sell, trade, or rent your personal information to third parties. We may share your information with trusted third-party service providers who assist us in operating the App, conducting our business, or servicing you, but only if those parties agree to keep this information confidential.\n3.2 We may disclose your information when we believe it is appropriate to comply with the law, enforce our site policies, or protect our or others' rights, property, or safety."
        label.numberOfLines = 0
        return label
    }()
    
    private let securityTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.text = "4. Security"
        return label
    }()
    
    private let securityLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .thin)
        label.text = "4.1 We implement reasonable security measures to protect your personal information from unauthorized access, disclosure, alteration, and destruction. However, please be aware that no method of transmission over the internet or electronic storage is 100% secure, and we cannot guarantee the absolute security of your data."
        label.numberOfLines = 0
        return label
    }()
    
    private let changesTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.text = "5. Changes to This Privacy Policy"
        return label
    }()
    
    private let changesLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .thin)
        label.text = "5.1 We may update this Privacy Policy from time to time by posting a new version on this page. You are advised to review this Privacy Policy periodically for any changes. Changes to this Privacy Policy are effective when they are posted on this page."
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .secondaryMain
        
        view.addSubview(scrollview)
        scrollview.snp.makeConstraints { make in
            make.left.right.equalTo(view.safeAreaLayoutGuide)
            make.top.bottom.equalToSuperview()
        }
        
        scrollview.addSubview(stackview)
        stackview.snp.makeConstraints { make in
            make.left.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-10)
            make.top.equalToSuperview().offset(20)
            make.bottom.equalToSuperview()
        }
        
        stackview.addArrangedSubview(informationTitle)
        stackview.addArrangedSubview(informationTextLabel)
        
        stackview.addArrangedSubview(usageTitle)
        stackview.addArrangedSubview(usageTextLabel)
        
        stackview.addArrangedSubview(sharingTitle)
        stackview.addArrangedSubview(sharingLabel)
        
        stackview.addArrangedSubview(securityTitle)
        stackview.addArrangedSubview(securityLabel)
        
        stackview.addArrangedSubview(changesTitle)
        stackview.addArrangedSubview(changesLabel)
    }
}
