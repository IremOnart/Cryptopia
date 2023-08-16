//
//  ViewController.swift
//  Cryptopia
//
//  Created by İrem Onart on 25.07.2023.
//

import UIKit
import CryptopiaAPI
import Kingfisher


final class CryptoListViewController: UIViewController, UISearchBarDelegate {
    @IBOutlet weak var tableView: UITableView!
    var viewModel: CryptopiaViewModelProtocol = CryptopiaViewModel()
    var coinList = [Coin]()
    let searchController = UISearchController(searchResultsController: nil)
    var textField: String = ""
    let service: TopCrytopiaProtocol = TopCrytopiaService()
    let emptyTransparentRowHeight: CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Coin List"
        tabBarController?.navigationController?.setNavigationBarHidden(true, animated: false)
        
        tableView.dataSource = self
        tableView.delegate = self
        viewModel.delegate = self
        
        let nib = UINib(nibName: "CryptopiaTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TableViewCell")
        
        self.tableView.layer.cornerRadius = 20.0
        self.navigationItem.setHidesBackButton(true, animated: true)
        searchController.searchBar.searchTextField.backgroundColor = .clear
        initSearchController()
        
        
        
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
        viewModel.getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        clearNavigationBar(clear: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        clearNavigationBar(clear: false)
    }
    
    
    func initSearchController(){
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        definesPresentationContext = true
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
}

extension CryptoListViewController {
    
    func clearNavigationBar(clear: Bool) {
        if clear {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            self.navigationController?.navigationBar.standardAppearance = appearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        } else {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            self.navigationController?.navigationBar.standardAppearance = appearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }
    }
}


extension CryptoListViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        self.viewModel.updateSearchController(searchBarText: searchController.searchBar.text)
        
    }
    
}

extension CryptoListViewController: CryptopiaViewModelDelegate{
    func handleViewModelOutput(_ output: CryptopiaViewModelOutput) {
        
    }
    
    func navigate(to route: CryptopiaViewRoute) {
        
    }
    
    func coinListFetch() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
}

extension CryptoListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let inSearchMode = self.viewModel.inSearchModel(searchController)
        return inSearchMode ? self.viewModel.filteredCoins.count : self.viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! CryptopiaTableViewCell
        
        let inSearchMode = self.viewModel.inSearchModel(searchController)
        let coin = inSearchMode ? self.viewModel.filteredCoins[indexPath.row] : self.viewModel.getCoin(for: indexPath)
        
        cell.coinNameLabel.text = coin.name
        cell.coinSymbolLabel.text = coin.symbol
        cell.priceLabel.text = Double(round(10000 * (coin.price ?? 0))/10000).formatted()
        cell.priceChangeLabel.text = "% \(Double(coin.priceChange1d ?? 0).formatted())"
        cell.iconImageView.kf.setImage(with: URL(string: coin.icon ?? ""))
        cell.priceChangeLabel.textColor = (coin.priceChange1d ?? 0.0) > 0 ? .green : (coin.priceChange1d ?? 0.0) < 0 ? .red : .black
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let inSearchMode = self.viewModel.inSearchModel(searchController)
        let coin = inSearchMode ? self.viewModel.filteredCoins[indexPath.row] : self.viewModel.getCoin(for: indexPath)
        
        let vm = CryptopiaDetailViewModel(coin: coin)
        let vc = CryptopiaDetailViewController(vm)
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
}
