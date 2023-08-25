//
//  CryptoNewsViewController.swift
//  Cryptopia
//
//  Created by İrem Onart on 25.08.2023.
//

import UIKit
import CryptopiaAPI
import SafariServices

class CryptoNewsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let viewModel = CryptoNewsViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Crpto News"
        
        let nib = UINib(nibName: "NewsTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "NewsTableViewCell")
        
        tabBarController?.navigationController?.setNavigationBarHidden(true, animated: false)
        tableView.dataSource = self
        tableView.delegate = self
        viewModel.delegate = self
        self.viewModel.getNewsData()
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(r: 219, g: 202, b: 227)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.purple]
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance
        navigationController?.navigationBar.tintColor = .purple
        
    }
    
}

extension CryptoNewsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell
        let news = self.viewModel.getCoin(for: indexPath)
        cell.titleLabel.text = news.title
        cell.descriptionLabel.text = news.description
        cell.newsImageView.kf.setImage(with: URL(string: news.urlToImage ?? ""))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let articles = self.viewModel.getCoin(for: indexPath)
        
        guard let url = URL(string: articles.url ?? "") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
}

extension CryptoNewsViewController: CryptoNewsViewModelDelegate {
    func newListFetch() {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
}
