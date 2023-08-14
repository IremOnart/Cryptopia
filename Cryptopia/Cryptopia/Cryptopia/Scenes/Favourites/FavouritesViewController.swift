//
//  FavouritesViewController.swift
//  Cryptopia
//
//  Created by İrem Onart on 14.08.2023.
//

import UIKit

final class FavouritesViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Favorites"
        tabBarController?.navigationController?.setNavigationBarHidden(true, animated: false)
    }
}
