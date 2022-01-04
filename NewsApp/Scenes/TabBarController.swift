//
//  TabBarController.swift
//  NewsApp
//
//  Created by Oleksandr Semeniuk on 15.12.2021.
//

import UIKit

final class TabBarController: UITabBarController {
        
    let typeText = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
//        let favoriteVC = createNavigation(
//            vc: FavoriteViewController,
//            itemName: "Favorite",
//            itemImage: "heart.fill")
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
            selectedImage: UIImage(systemName: itemImage)
        )
        
        let navigation = UINavigationController(rootViewController: vc)
        navigation.tabBarItem = item
       
        return navigation
    }
    

}
