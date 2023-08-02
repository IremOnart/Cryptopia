//
//  CryptopiaTableViewCell.swift
//  Cryptopia
//
//  Created by İrem Onart on 26.07.2023.
//

import UIKit

class CryptopiaTableViewCell: UITableViewCell {

    var iconImage: UIImage?
    var coinName: String?{
        didSet{
            coinNameLabel.text = coinName
        }
    }
    @IBOutlet weak var iconImageView: UIImageView! {
        didSet{
            iconImageView.image = iconImage
        }
    }
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
