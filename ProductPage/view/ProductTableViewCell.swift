//
//  ProductTableViewCell.swift
//  ProductPage
//
//  Created by elliott on 4/12/22.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet var name: UILabel!
    @IBOutlet var price: UILabel!
    @IBOutlet var productImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.name.adjustsFontSizeToFitWidth = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
