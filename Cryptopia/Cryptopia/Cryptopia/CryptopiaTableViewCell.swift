//
//  CryptopiaTableViewCell.swift
//  Cryptopia
//
//  Created by İrem Onart on 26.07.2023.
//

import UIKit

class CryptopiaTableViewCell: UITableViewCell {
    
    @IBOutlet private(set) weak var iconImageView: UIImageView!
    @IBOutlet private weak var coinNameLabel: UILabel!
    @IBOutlet private weak var coinSymbolLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var priceChangeLabel: UILabel!
    
    var iconImage: UIImage? {
        didSet{
            iconImageView.image = iconImage
        }
    }
    var coinName: String = "" {
        didSet{
            coinNameLabel.text = coinName
        }
    }
    var coinSymbol: String = "" {
        didSet{
            coinSymbolLabel.text = coinSymbol
        }
    }
    var price: String = "" {
        didSet{
            priceLabel.text = price
        }
    }
    var priceChange: Double = 0 {
        didSet{
            priceChangeLabel.text = priceChange.formatted()
            priceChangeLabel.textColor = priceChange > 0 ? .green : priceChange < 0 ? .red : .black
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
     
    }

}
