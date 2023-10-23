//
//  AboutUsVC.swift
//  EventGo
//
//  Created by Abdulkerim Can on 21.10.2023.
//

import UIKit

final class AboutUsVC: UIViewController {
    
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
    
    private let aboutTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.text = "About EventGO"
        return label
    }()
    private let aboutLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .thin)
        label.text = "Welcome to EventGO, your go-to platform for creating, discovering, and joining events seamlessly! At EventGO, we are passionate about fostering meaningful connections and making event planning a breeze. Whether you're hosting a gathering, looking for exciting events to attend, or simply want to explore your local community, EventGO has got you covered."
        label.numberOfLines = 0
        return label
    }()
    
    private let missionTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.text = "Our Mission"
        return label
    }()
    private let missionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .thin)
        label.text = "At EventGO, our mission is to bring people together through the magic of events. We believe that every event, regardless of its size or type, has the power to create memories, inspire passions, and build communities. We are dedicated to providing a user-friendly platform that empowers event organizers and attendees alike, making the event experience enjoyable and hassle-free."
        label.numberOfLines = 0
        return label
    }()
    
    private let keyfeaturesTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.text = "Key Features"
        return label
    }()
    private let keyfeaturesLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .thin)
        label.text = "Create and Join Events: Host your event or find events tailored to your interests effortlessly. With EventGO, you can easily create events, manage guest lists, and send invitations. Likewise, discovering exciting events and joining them is just a click away.\nEvent Categories/Types: Explore events based on categories or types that match your preferences. Whether you're into arts and culture, sports, education, or entertainment, EventGO helps you find events that resonate with your passions.\nLocation-Based Discovery: Discover events in your vicinity! Our location-based feature ensures you never miss out on events happening near you. Connect with your local community and explore events in your neighborhood effortlessly.\nCalendar Integration: Seamlessly integrate events with your calendar. Keep track of your schedule by adding events to your calendar directly from the app. Stay organized and plan your activities ahead of time.\nEvent Reviews: Share your experiences and insights by writing reviews for events you attend. Your reviews help others make informed decisions and contribute to creating a vibrant event community."
        label.numberOfLines = 0
        return label
    }()
    
    private let joinUsTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.text = "Join Us on the Journey"
        return label
    }()
    private let joinUsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .thin)
        label.text = "Join us on this exciting journey of bringing people together, one event at a time. Whether you're a passionate event organizer or an enthusiastic event-goer, EventGO is here to enhance your event experience. Let's make memories, forge connections, and celebrate life's moments together.\n\nThank you for being a part of the EventGO community. We look forward to helping you discover, create, and enjoy memorable events!\n\nWarm regards,\n\nThe EventGO Team"
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
        
        stackview.addArrangedSubview(aboutTitle)
        stackview.addArrangedSubview(aboutLabel)
        
        stackview.addArrangedSubview(missionTitle)
        stackview.addArrangedSubview(missionLabel)
        
        stackview.addArrangedSubview(keyfeaturesTitle)
        stackview.addArrangedSubview(keyfeaturesLabel)
        
        stackview.addArrangedSubview(joinUsTitle)
        stackview.addArrangedSubview(joinUsLabel)
        
    }
}
