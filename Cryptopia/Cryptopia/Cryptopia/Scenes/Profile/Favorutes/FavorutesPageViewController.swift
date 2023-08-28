//
//  FavorutesPageViewController.swift
//  Cryptopia
//
//  Created by İrem Onart on 26.08.2023.
//

import UIKit
import CryptopiaAPI
import Kingfisher

final class FavorutesPageViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    let viewModel = FavoutesPageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        title = "Favorites"
        tabBarController?.navigationController?.setNavigationBarHidden(true, animated: false)
        tabBarController?.tabBar.barTintColor = .white
        
        let nib = UINib(nibName: "CryptopiaTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TableViewCell")
        viewModel.getFavoriteId()
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
        self.viewModel.getFavoriteId()
    }
}


extension FavorutesPageViewController: UITableViewDelegate, UITableViewDataSource{
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
        cell.priceChangeLabel.text =  "% \(Double(data.priceChange1h ).formatted())"
        cell.iconImageView.kf.setImage(with: URL(string: data.icon ))
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let data = self.viewModel.getData(for: indexPath)
        
        let vm = CryptopiaDetailViewModel(coin: data)
        let vc = CryptopiaDetailViewController(vm)
        vc.hiddenBoolean = true
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}

extension FavorutesPageViewController: FavouritesViewModelDelegate{
    func coinListFetch() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
}
