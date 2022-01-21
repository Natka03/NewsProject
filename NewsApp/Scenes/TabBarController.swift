//
//  TabBarController.swift
//  NewsApp
//
//  Created by Oleksandr Semeniuk on 15.12.2021.
//

import UIKit

final class TabBarController: UITabBarController {

    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabBar()
    }
    
    //MARK: - Private methods

    private func setUpTabBar() {

        let emailedVC = createNavigation(
            vc: NewsViewControler(somePresenter: NewsPresenter(nesType: .mostEmailed), navBarTitle: .mostEmailed),
            itemName: "Most Emailed",
            itemImage: "folder")
        
        let sharedVC = createNavigation(
            vc: NewsViewControler(somePresenter: NewsPresenter(nesType: .mostShared), navBarTitle: .mostShared),
            itemName: "Most Shared",
            itemImage: "folder")
        
        let viewedVC = createNavigation(
            vc: NewsViewControler(somePresenter: NewsPresenter(nesType: .mostVived), navBarTitle: .mostVived),
            itemName: "Most Viewed",
            itemImage: "folder")
        
        let favoriteVC = createNavigation(
            vc: NewsViewControler(somePresenter: FavoritePresenter(nesType: .mostFavorite), navBarTitle: .mostFavorite),
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
