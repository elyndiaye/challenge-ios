//
//  ProductCell.swift
//  Lodjinha
//
//  Created by ely.assumpcao.ndiaye on 19/06/19.
//  Copyright © 2019 ely.assumpcao.ndiaye. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productLbl: UILabel!
    @IBOutlet weak var precoPor: UILabel!
    @IBOutlet weak var precoDe: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
