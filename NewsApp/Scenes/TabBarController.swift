//
//  TabBarController.swift
//  NewsApp
//
//  Created by Oleksandr Semeniuk on 15.12.2021.
//

import UIKit

final class TabBarController: UITabBarController {

    private var modelCell: [NewsTableViewCellModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabBar()
    }
    
    private func setUpTabBar() {
        let emailedVC = createNavigation(
            vc: MostEmailedViewController(),
            itemName: "Most Emailed",
            itemImage: "folder")
        
        let sharedVC = createNavigation(
            vc: MostSharedViewController(),
            itemName: "Most Shared",
            itemImage: "folder")
        
        let viewedVC = createNavigation(
            vc: MostViewedViewController(),
            itemName: "Most Viewed",
            itemImage: "folder")
        
        let favoriteVC = createNavigation(
            vc: FavoriteViewController(),
            itemName: "Favorite",
            itemImage: "heart")
        
        viewControllers = [emailedVC, sharedVC, viewedVC, favoriteVC]
    }
    
    private func createNavigation(
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
