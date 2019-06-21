//
//  DetailProductWorker.swift
//  Lodjinha
//
//  Created by ely.assumpcao.ndiaye on 20/06/19.
//  Copyright (c) 2019 ely.assumpcao.ndiaye. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

class DetailProductWorker
{
    func fetchProductById(productId: Int, completionHandler: @escaping ([ProdutosById]) -> Void){
        print("Chamou MaisVendidos")
        NetworkManager.shared.getProductById(withProductId: "\(productId)") { produto in
            completionHandler(produto)
        }
    }
}
