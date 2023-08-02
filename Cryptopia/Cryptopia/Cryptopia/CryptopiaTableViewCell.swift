//
//  CryptopiaTableViewCell.swift
//  Cryptopia
//
//  Created by İrem Onart on 26.07.2023.
//

import UIKit

class CryptopiaTableViewCell: UITableViewCell {

    var iconImage: UIImage?{
        didSet{
            iconImageView.image = iconImage
        }
    }
    var coinName: String?{
        didSet{
            coinNameLabel.text = coinName
        }
    }
    var coinSymbol: String?{
        didSet{
            coinSymbolLabel.text = coinSymbol
        }
    }
    var price: String?{
        didSet{
            priceLabel.text = price
        }
    }
    var percentSymbol: String?{
        didSet{
            percentSymbolLabel.text = percentSymbol
        }
    }
    var priceChange: String?{
        didSet{
            priceChangeLabel.text = priceChange
        }
    }
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var coinNameLabel: UILabel!
    @IBOutlet weak var coinSymbolLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var percentSymbolLabel: UILabel!
    @IBOutlet weak var priceChangeLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
     
    }

}
