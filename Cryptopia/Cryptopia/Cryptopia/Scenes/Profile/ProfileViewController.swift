//
//  ProfileViewController.swift
//  Cryptopia
//
//  Created by İrem Onart on 11.08.2023.
//

import UIKit

final class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        tabBarController?.navigationController?.setNavigationBarHidden(true, animated: false)
    }
}
