//
//  OnboardViewModel.swift
//  EventGo
//
//  Created by Abdulkerim Can on 10.10.2023.
//

import Foundation

protocol OnboardViewModelDelegate {
    var view: OnboardVCDelegate? {get set}
    func viewDidLoad()
    func didTapNext()
    func didTapSkip()
}

final class OnboardViewModel {
    weak var view: OnboardVCDelegate?
    var selectedIndex = 0
    let onboardElements: [OnBoardModel] = [OnBoardModel(title: "Exploring Upcoming and Nearby Events" ,
                                                        subtitle: "Discover Exciting Opportunities in Your Area and Beyond!",
                                                        image: "onboard1"),
                                           OnBoardModel(title: "Easily Add Events to Your Calendar",
                                                        subtitle: "Effortlessly Organize Your Schedule: Seamlessly Add Events to Your Calendar!",
                                                        image: "onboard2"),
                                           OnBoardModel(title: "Instantly Search for Events Around You with Maps",
                                                        subtitle: "Navigate Your World: Explore Nearby Events with Interactive Maps!",
                                                        image: "onboard3")]
    
}

extension OnboardViewModel: OnboardViewModelDelegate {
    func didTapSkip() {
        
        UserDefaults.standard.set(true, forKey: "isFirstUser")
        view?.navigateToLoginScreen()
    }
    
    
    func didTapNext() {
        selectedIndex += 1
        
        if selectedIndex < onboardElements.count {
            view?.updateUI(model: onboardElements[selectedIndex])
            
        } else {
            UserDefaults.standard.set(true, forKey: "isFirstUser")
            view?.navigateToLoginScreen()
        }
    }
    
    func viewDidLoad() {
        view?.configureContainer()
    }
}
