//
//  ViewController.swift
//  Cryptopia
//
//  Created by İrem Onart on 25.07.2023.
//

import UIKit
import CryptopiaAPI


class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var viewModel: CryptopiaViewModelProtocol = CryptopiaViewModel()
    
    let service: TopCrytopiaProtocol = TopCrytopiaService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.dataSource = self
        tableView.delegate = self
        
        viewModel.delegate = self
        viewModel.getData()
        
       
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
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! CryptopiaTableViewCell
        
        let coin = viewModel.getCoin(for: indexPath)
        cell.coinNameLabel.text = coin.name
        return cell
        
    }
    
    
    
    
    
}
