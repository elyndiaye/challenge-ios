//
//  HomePresenter.swift
//  Lodjinha
//
//  Created by ely.assumpcao.ndiaye on 16/06/19.
//  Copyright (c) 2019 ely.assumpcao.ndiaye. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol HomePresentationLogic {
    func presentInitalDatas(response: HomeScenes.Load.Response)
    func presentDetailProduct(response: HomeScenes.DetailProduct.Response)
    
}

class HomePresenter: HomePresentationLogic
{
    weak var viewController: HomeDisplayLogic?
    
    // MARK: Do something
    
    func presentInitalDatas(response: HomeScenes.Load.Response)
    {
        let viewModel = HomeScenes.Load.ViewModel(banners: response.banners, categories: response.categories, produtosMaisVendidos: response.produtosMaisVendidos)
        viewController?.displayInitialDatas(viewModel: viewModel)
    }
    
    func presentDetailProduct(response: HomeScenes.DetailProduct.Response) {
        let viewModel = HomeScenes.DetailProduct.ViewModel()
        viewController?.displayDetailProduct(viewModel: viewModel)
    }
}
