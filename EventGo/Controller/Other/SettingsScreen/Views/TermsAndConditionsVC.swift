//
//  TermsAndConditionsVC.swift
//  EventGo
//
//  Created by Abdulkerim Can on 21.10.2023.
//

import UIKit
import SnapKit

final class TermsAndConditionsVC: UIViewController {
    
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
    
    private let acceptanceTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.text = "1. Acceptance of Terms"
        return label
    }()
    private let acceptanceTextLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .thin)
        label.text = "By accessing or using the EventGO mobile application, you agree to comply with and be bound by these Terms and Conditions (the Terms). If you do not agree to these Terms, please do not use the App."
        label.numberOfLines = 0
        return label
    }()
    
    private let usageTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.text = "2. Use of the App"
        return label
    }()
    private let usageTextLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .thin)
        label.text = "2.1 You must be at least 18 years old to use the EventGO App.\n2.2 You agree to use the App in accordance with all applicable laws and regulations.\n2.3 You are solely responsible for maintaining the confidentiality of your account and password and for restricting access to your mobile device. You agree to accept responsibility for all activities that occur under your account."
        label.numberOfLines = 0
        return label
    }()
    
    private let contentTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.text = "3. User Content"
        return label
    }()
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .thin)
        label.text = "3.1 The EventGO App allows users to post content, including but not limited to, text, images, and videos (User Content) \n3.2 By posting User Content on the EventGO App, you grant EventGO and its affiliates a non-exclusive, royalty-free, worldwide, irrevocable, sub-licensable license to use, reproduce, modify, adapt, publish, translate, create derivative works from, distribute, and display such content in any form, media, or technology. \n3.3 You agree not to post User Content that is defamatory, harmful, abusive, obscene, infringing, or racially, ethnically, or otherwise objectionable."
        label.numberOfLines = 0
        return label
    }()
    
    private let propertyTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.text = "4. Intellectual Property"
        return label
    }()
    private let propertyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .thin)
        label.text = "4.1 All content and materials available on the EventGO App, including but not limited to trademarks, logos, service marks, and software, are the property of EventGO and its licensors and are protected by copyright, trademark, and other intellectual property laws."
        label.numberOfLines = 0
        return label
    }()
    
    
    
    private let disclaimerTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.text = "5. Disclaimer"
        label.numberOfLines = 0
        return label
    }()
    private let disclaimerLabel: UILabel = {
        let label = UILabel()
        label.text = "5.1 The EventGO App is provided on an as-is and as-available basis without any warranties of any kind, either express or implied, including, but not limited to, the implied warranties of merchantability, fitness for a particular purpose, or non-infringement.\n5.2 EventGO does not warrant that the App will be uninterrupted or error-free, that defects will be corrected, or that the App or the servers that make it available are free of viruses or other harmful components."
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .thin)
        return label
    }()
    
    private let limitationTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.text = "6. Limitation of Liability"
        return label
    }()
    private let limitationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .thin)
        label.text = "6.1 EventGO shall not be liable for any indirect, incidental, special, consequential, or punitive damages, or any loss of profits or revenues, whether incurred directly or indirectly, or any loss of data, use, goodwill, or other intangible losses resulting from (a) your use or inability to use the EventGO App; (b) any unauthorized access to or use of our servers and/or any personal information stored therein."
        label.numberOfLines = 0
        return label
    }()
    
    
    private let changesTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.text = "7. Changes to Terms"
        return label
    }()
    private let changesLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .thin)
        label.text = "7.1 EventGO reserves the right to modify or replace these Terms at any time. Your continued use of the EventGO App after any such changes constitutes your acceptance of the new Terms.\nBy using the EventGO App, you signify your acceptance of these Terms. If you do not agree to these Terms, please do not use the App."
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
        
        stackview.addArrangedSubview(acceptanceTitle)
        stackview.addArrangedSubview(acceptanceTextLabel)
        
        stackview.addArrangedSubview(usageTitle)
        stackview.addArrangedSubview(usageTextLabel)
        
        stackview.addArrangedSubview(contentTitle)
        stackview.addArrangedSubview(contentLabel)
        
        stackview.addArrangedSubview(propertyTitle)
        stackview.addArrangedSubview(propertyLabel)
        
        stackview.addArrangedSubview(disclaimerTitle)
        stackview.addArrangedSubview(disclaimerLabel)
        
        stackview.addArrangedSubview(limitationTitle)
        stackview.addArrangedSubview(limitationLabel)
        
        stackview.addArrangedSubview(changesTitle)
        stackview.addArrangedSubview(changesLabel)
        
        
    }
}
