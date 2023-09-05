//
//  NewsTableViewCell.swift
//  Cryptopia
//
//  Created by İrem Onart on 25.08.2023.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

 
    @IBOutlet weak var newsImageView: UIImageView!{
        didSet{
            newsImageView.layer.cornerRadius = 10
        }
    }
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
//    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
