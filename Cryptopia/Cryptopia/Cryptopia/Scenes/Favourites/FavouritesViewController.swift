//
//  FavouritesViewController.swift
//  Cryptopia
//
//  Created by İrem Onart on 14.08.2023.
//

import UIKit
import CryptopiaAPI


final class FavouritesViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    let viewModel = FavouritesViewModel()
    let defaults = UserDefaults.standard
    let models = [FavouritesModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        title = "Favorites"
        tabBarController?.navigationController?.setNavigationBarHidden(true, animated: false)
        
        let nib = UINib(nibName: "CryptopiaTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TableViewCell")
        viewModel.fetchData()
        self.tableView.reloadData()
        
    
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(r: 219, g: 202, b: 227)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.purple]
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance
        navigationController?.navigationBar.tintColor = .purple
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.viewModel.fetchData()
    }
}


extension FavouritesViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRows
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! CryptopiaTableViewCell
        let data  = self.viewModel.getData(for: indexPath)
        print(data.name)
        cell.coinNameLabel.text = data.name
        cell.coinSymbolLabel.text = data.symbol
        cell.priceLabel.text = Double(round(10000 * (data.price ))/10000).formatted()
        cell.priceChangeLabel.text =  "% \(Double(data.priceChange ).formatted())"
       
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let data = self.viewModel.getData(for: indexPath)
        
    }
    
}


extension FavouritesViewController: FavouritesViewModelDelegate{
    func coinListFetch() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
}

