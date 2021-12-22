//
//  TabBarController.swift
//  NewsApp
//
//  Created by Oleksandr Semeniuk on 15.12.2021.
//

import UIKit

enum SomeEnum: Int {
    case mostEmailed = 0
    case mostViewed = 1
    case mostShared = 2
}

final class TabBarController: UITabBarController {
    
    //some test changes, remove after
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  tabBar.unselectedItemTintColor = .black
        setUpTabBar()
    }
    
    func setUpTabBar(){
        let emailedVC = createNavigation(
            vc: MostEmailedViewController(),
            itemName: "Most Emailed",
            itemImage: "calendar.badge.clock")
        let sharedVC = createNavigation(
            vc: MostSharedViewController(),
            itemName: "Most Shared",
            itemImage: "calendar.badge.clock")
        let viewedVC = createNavigation(
            vc: MostViewedViewController(),
            itemName: "Most Viewed",
            itemImage: "calendar.badge.clock")
        viewControllers = [emailedVC, sharedVC, viewedVC]       
    }
    
    func createNavigation(
        vc: UIViewController,
        itemName: String,
        itemImage: String
    ) -> UINavigationController {
  
        let item = UITabBarItem(
            title: itemName,
            image: UIImage(systemName: itemImage),
            selectedImage: UIImage(systemName: itemImage)// how to change to collor
        )
        
        let navigation = UINavigationController(rootViewController: vc)
        navigation.tabBarItem = item
       
        return navigation
    }
    

}
