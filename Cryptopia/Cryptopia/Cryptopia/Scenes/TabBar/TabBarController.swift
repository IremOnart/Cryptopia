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
        
        let profileViewController = ProfileViewController()
        profileViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "list.bullet"), tag: 0)
        profileViewController.tabBarController?.tabBar.tintColor = .darkGray
        profileViewController.tabBarController?.tabBar.unselectedItemTintColor = .lightGray
        let profileNavigationController = UINavigationController(rootViewController: profileViewController)
        
        let listViewController = CryptoListViewController()
        listViewController.tabBarItem = UITabBarItem(title: "Coin List", image: UIImage(systemName: "star.fill"), tag: 1)
        listViewController.tabBarController?.tabBar.tintColor = .darkGray
        listViewController.tabBarController?.tabBar.unselectedItemTintColor = .lightGray
        let listNavigationController = UINavigationController(rootViewController: listViewController)
        
        let favouriteViewController = CryptoNewsViewController()
        favouriteViewController.tabBarItem = UITabBarItem(title: "Crypto News", image: UIImage(systemName: "brain.head.profile"), tag: 2)
        favouriteViewController.tabBarController?.tabBar.tintColor = .darkGray
        favouriteViewController.tabBarController?.tabBar.unselectedItemTintColor = .lightGray
        let favouriteNavigationController = UINavigationController(rootViewController: favouriteViewController)
        
        self.tabBar.backgroundColor = .white
        
        viewControllers = [profileNavigationController, listNavigationController, favouriteNavigationController]
    }
}
