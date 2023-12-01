//
//  CryptoTableViewCell.swift
//  CryptoApp
//
//  Created by Terry Jason on 2023/12/1.
//

import UIKit

class CryptoTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    public var item: Crypto! {
        didSet {
            self.nameLabel.text = item.currency
            self.priceLabel.text = item.price
        }
    }
    
}


