//
//  TabBarController.swift
//  Cryptopia
//
//  Created by İrem Onart on 11.08.2023.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad(){
        super.viewDidLoad()
        
        let profileController = ProfileViewController()
        let navigationController2 = UINavigationController(rootViewController: profileController)
        let listController = CryptoListViewController()
        let navigationController = UINavigationController(rootViewController: listController)
        let favouriteController = FavouritesViewController()
        let navigationController3 = UINavigationController(rootViewController: favouriteController)
        
        viewControllers = [navigationController, navigationController2, navigationController3]
        
        self.viewControllers?[0].tabBarItem.title = NSLocalizedString("List", comment: "")
        self.viewControllers?[1].tabBarItem.title = NSLocalizedString("Favourites", comment: "")
        self.viewControllers?[2].tabBarItem.title = NSLocalizedString("Profile", comment: "")
        
        guard let items = self.tabBar.items else {
            return
        }
        let images = ["list.bullet","star.fill","brain.head.profile"]
        
        for x in 0..<images.count {
            items[x].image = UIImage(systemName: images[x])
        }
        self.tabBar.tintColor = .darkGray
        self.tabBar.unselectedItemTintColor = .lightGray
        UITabBar.appearance().barTintColor = UIColor(r: 219, g: 202, b: 227)
//        self.tabBar.backgroundColor =  UIColor(r: 219, g: 202, b: 227)
    }
    
//        override func viewWillAppear(_ animated: Bool) {
//            super.viewWillAppear(animated)
//            let appearance = UITabBarAppearance()
//                   appearance.backgroundColor =  UIColor(r: 219, g: 202, b: 227)
//
//                   setTabBarItemColors(appearance.stackedLayoutAppearance)
//                   setTabBarItemColors(appearance.inlineLayoutAppearance)
//                   setTabBarItemColors(appearance.compactInlineLayoutAppearance)
//
//                   setTabBarItemBadgeAppearance(appearance.stackedLayoutAppearance)
//                   setTabBarItemBadgeAppearance(appearance.inlineLayoutAppearance)
//                   setTabBarItemBadgeAppearance(appearance.compactInlineLayoutAppearance)
//
//                   tabBar.standardAppearance = appearance
//        }
//
//        @available(iOS 13.0, *)
//        private func setTabBarItemColors(_ itemAppearance: UITabBarItemAppearance) {
//            itemAppearance.normal.iconColor = .lightGray
//            itemAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
//            itemAppearance.selected.iconColor = .white
//            itemAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.orange]
//        }
//
//        @available(iOS 13.0, *)
//        private func setTabBarItemBadgeAppearance(_ itemAppearance: UITabBarItemAppearance) {
//            //Adjust the badge position as well as set its color
//            itemAppearance.normal.badgeBackgroundColor = .orange
//            itemAppearance.normal.badgeTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
//            itemAppearance.normal.badgePositionAdjustment = UIOffset(horizontal: 1, vertical: -1)
//        }
    
}
