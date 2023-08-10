//
//  CryptopiaTableViewCell.swift
//  Cryptopia
//
//  Created by İrem Onart on 26.07.2023.
//

import UIKit

class CryptopiaTableViewCell: UITableViewCell {
    
    var iconImage: UIImage?
    @IBOutlet weak var iconImageView: UIImageView! {
        didSet{
            iconImageView.image = iconImage
        }
    }
    @IBOutlet weak var coinNameLabel: UILabel!
    @IBOutlet weak var coinSymbolLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceChangeLabel: UILabel!
    
    var rightBorder: CALayer?
    
    var borderWidth: CGFloat = 5
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Add right border if we haven't already
        if rightBorder == nil {
            addRightBorder()
        }
        
        
        // Update the frames based on the current bounds
        rightBorder?.frame = CGRect(x: bounds.maxX - borderWidth,
                                    y: 0,
                                    width: borderWidth,
                                    height: bounds.maxY)
    }
    
    private func addRightBorder() {
        rightBorder = CALayer()
        
        rightBorder!.backgroundColor = UIColor.red.cgColor
        
        layer.addSublayer(rightBorder!)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
}
