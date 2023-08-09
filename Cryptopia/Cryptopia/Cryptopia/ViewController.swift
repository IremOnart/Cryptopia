//
//  ViewController.swift
//  Cryptopia
//
//  Created by İrem Onart on 25.07.2023.
//

import UIKit
import CryptopiaAPI
import Kingfisher


class ViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel: CryptopiaViewModelProtocol = CryptopiaViewModel()
    var coinList = [Coin]()
    let searchController = UISearchController(searchResultsController: nil)
    var textField: String = ""
    let service: TopCrytopiaProtocol = TopCrytopiaService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.dataSource = self
        tableView.delegate = self
        viewModel.delegate = self
        
        searchController.searchBar.searchTextField.backgroundColor = .clear
        initSearchController()
        
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
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = .done
        definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}

extension UIViewController {
    
    func clearNavigationBar(clear: Bool) {
        let appearance = UINavigationBarAppearance()
        if clear {
            appearance.configureWithTransparentBackground()
            self.navigationController?.navigationBar.standardAppearance = appearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        } else {
            appearance.configureWithOpaqueBackground()
            self.navigationController?.navigationBar.standardAppearance = appearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }
    }
}


extension ViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        self.viewModel.updateSearchController(searchBarText: searchController.searchBar.text)
        _ = self.viewModel.inSearchModel(searchController)
    }
    
}

extension ViewController: CryptopiaViewModelDelegate{
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

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! CryptopiaTableViewCell
        let coin = self.viewModel.getCoin(for: indexPath)
        cell.coinName = coin.name ?? ""
        cell.coinSymbol = coin.symbol ?? ""
        cell.price = Double(round(10000 * (coin.price ?? 0))/10000).formatted()
        cell.priceChange = coin.priceChange1d ?? .zero
        cell.iconImageView.kf.setImage(with: URL(string: coin.icon ?? ""))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let coin = self.viewModel.getCoin(for: indexPath)
        let vm = CryptopiaDetailViewModel(coin: coin)
        let vc = CryptopiaDetailViewController(vm)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
