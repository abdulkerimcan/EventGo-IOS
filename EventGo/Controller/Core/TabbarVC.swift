//
//  TabbarVC.swift
//  EventGo
//
//  Created by Abdulkerim Can on 11.10.2023.
//

import UIKit

final class TabbarVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "secondaryMainColor")
        setTabs()
        
    }
    
    private func setTabs() {
        let navs = [createHomeVC(),createEventListVC(),createEventsMapVC(),createCalendarVC(),createProfileVC()]
        view.tintColor = UIColor(named: "mainColor")
        setViewControllers(navs, animated: true)
    }
}

private extension TabbarVC {
    
    func createHomeVC() -> UINavigationController {
        let homeVC = HomeVC()
        let nav = UINavigationController(rootViewController: homeVC)
        nav.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 1)
        return nav
    }
    
    func createEventListVC() -> UINavigationController {
        let eventListVC = EventListVC()
        let nav = UINavigationController(rootViewController: eventListVC)
        nav.tabBarItem = UITabBarItem(title: "My Events", image: UIImage(systemName: "calendar"), tag: 2)
        return nav
    }
    func createEventsMapVC() -> UINavigationController {
        let eventMapVC = EventMapVC()
        let nav = UINavigationController(rootViewController: eventMapVC)
        nav.tabBarItem = UITabBarItem(title: "Near by", image: UIImage(systemName: "map"), tag: 3)
        return nav
    }
    func createCalendarVC() -> UINavigationController {
        let calendarVC = CalendarVC()
        let nav = UINavigationController(rootViewController: calendarVC)
        nav.tabBarItem = UITabBarItem(title: "Calendar", image: UIImage(systemName: "calendar.day.timeline.left"), tag: 4)
        return nav
    }
    func createProfileVC() -> UINavigationController {
        let profileVC = ProfileVC()
        let nav = UINavigationController(rootViewController: profileVC)
        nav.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.fill"), tag: 5)
        return nav
    }
}
