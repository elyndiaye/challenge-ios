//
//  ProductListCell.swift
//  Lodjinha
//
//  Created by ely.assumpcao.ndiaye on 21/06/19.
//  Copyright © 2019 ely.assumpcao.ndiaye. All rights reserved.
//

import UIKit

class ProductListCell: UITableViewCell {

    
    @IBOutlet weak var ProductListImageView: UIImageView!
    @IBOutlet weak var productListLbl: UILabel!
    @IBOutlet weak var precoDeLbl: UILabel!
    @IBOutlet weak var precoPorLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
