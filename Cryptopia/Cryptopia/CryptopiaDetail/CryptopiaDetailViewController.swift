//
//  CryptopiaDetailViewController.swift
//  Cryptopia
//
//  Created by İrem Onart on 27.07.2023.
//

import UIKit
import CryptopiaAPI
import Kingfisher
import Charts
import DGCharts

class CryptopiaDetailViewController: UIViewController {
    
    let viewModel: CryptopiaDetailViewModel
    init(_ viewModel: CryptopiaDetailViewModel) {
            self.viewModel = viewModel
            super.init(nibName: nil, bundle: nil)
        }
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var coinNameLabel: UILabel!{
        didSet{
            coinNameLabel.text = viewModel.coin.name
        }
    }
    @IBOutlet weak var coinImageView: UIImageView!{
        didSet{
            coinImageView.kf.setImage(with: URL(string: viewModel.coin.icon ?? ""))
        }
    }
    @IBOutlet weak var priceLabel: UILabel!{
        didSet{
            priceLabel.text = "$ \(round(10000 * (viewModel.coin.price ?? 0))/10000)"
            
        }
    }
    @IBOutlet weak var priceChangeLabel: UILabel!{
        didSet{
            priceChangeLabel.text = "% \(viewModel.coin.priceChange1d ?? 0)"
            priceChangeLabel.textColor = viewModel.coin.priceChange1d ?? 0 > 0 ? .green : viewModel.coin.priceChange1d ?? 0 < 0 ? .red : .black
        }

    }
    
    @IBOutlet weak var lineChartView: LineChartView!
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lineChartView.backgroundColor = .white
        title = viewModel.coin.symbol
        print(viewModel.coin.name ?? "")
        viewModel.getData()
        
        viewModel.delegate = self
        
        
        
    }
    
}

extension CryptopiaDetailViewController: CryptopiaDetailViewModelDelegate{
    func didCoinDetailFetched() {
        DispatchQueue.main.async {
            self.lineChartView.data = self.viewModel.getChartData()
        }
        
    }
    
    
}

extension CryptopiaDetailViewController: ChartViewDelegate {
     
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
}
