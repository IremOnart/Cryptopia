//
//  FavouritesViewController.swift
//  Cryptopia
//
//  Created by İrem Onart on 14.08.2023.
//

import UIKit

class FavouritesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tabBarItem.title = "Favourites"
        UITabBar.appearance().barTintColor = UIColor(r: 219, g: 202, b: 227)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
