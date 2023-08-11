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
        let listController = CryptoListViewController()
        let favouriteController = SignUpViewController()
        
        
        self.setViewControllers([profileController, listController, favouriteController], animated: true)
    }
}
