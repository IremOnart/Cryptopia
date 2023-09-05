//
//  CryptopiaTableViewCell.swift
//  Cryptopia
//
//  Created by İrem Onart on 26.07.2023.
//

import UIKit

class CryptopiaTableViewCell: UITableViewCell {
    
    var iconImage: UIImage?
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var iconImageView: UIImageView! {
        didSet{
            iconImageView.image = iconImage
        }
    }
    @IBOutlet weak var coinNameLabel: UILabel!
    @IBOutlet weak var coinSymbolLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceChangeLabel: UILabel!
    
    
    var borderWidth: CGFloat = 5
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        applyShadow(cornerRadius: 8)
        self.containerView.layer.cornerRadius = 8
        self.containerView.layer.masksToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
   
}
extension UIView {
    func applyShadow(cornerRadius: CGFloat){
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
        layer.shadowRadius = 4.0
        layer.shadowOpacity = 0.30
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5)
    }
}
