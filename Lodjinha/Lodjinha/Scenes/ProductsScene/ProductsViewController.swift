//
//  ProductsViewController.swift
//  Lodjinha
//
//  Created by ely.assumpcao.ndiaye on 21/06/19.
//  Copyright (c) 2019 ely.assumpcao.ndiaye. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ProductsDisplayLogic: class
{
    func displayInitialData(viewModel: Products.Load.ViewModel)
    func displayDetailProduct(viewModel: Products.DetailProduct.ViewModel)
}

class ProductsViewController: UIViewController, ProductsDisplayLogic
{
    
    
    var interactor: ProductsBusinessLogic?
    var router: (NSObjectProtocol & ProductsRoutingLogic & ProductsDataPassing)?
    var arrayProductsList = [Produtos]()
    
    @IBOutlet weak var productsTableView: UITableView!
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = ProductsInteractor()
        let presenter = ProductsPresenter()
        let router = ProductsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        loadInitialData()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // loadInitialData()
        title = "Produtos"
        print("Chamou Produtos Lista:\(router?.dataStore?.categoriaId)")
        
        productsTableView.delegate = self
        productsTableView.dataSource = self
    }
    
    // MARK: Do something
    
    //@IBOutlet weak var nameTextField: UITextField!
    
    func loadInitialData()
    {
        let request = Products.Load.Request()
        interactor?.doLoadInitialData(request: request)
    }
    
    func displayInitialData(viewModel: Products.Load.ViewModel) {
        arrayProductsList = viewModel.produtos
        
        DispatchQueue.main.async {
            self.productsTableView.reloadData()
        }
    }
    
    func displayDetailProduct(viewModel: Products.DetailProduct.ViewModel) {
        router?.routeToDetailProduct()
    }
}

extension ProductsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 2
        if arrayProductsList.isEmpty{
            count = 2
        }else {
            count = arrayProductsList[0].data.count
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier:"productListCell", for: indexPath) as? ProductListCell {
            
            if arrayProductsList.isEmpty{
                cell.ProductListImageView.kf.indicatorType = .activity
                cell.ProductListImageView.kf.setImage(with: URL(string: "https://gph.is/1XRTmuh")!)   }
            else {
                
                let produtos = arrayProductsList[0]
                cell.productListLbl.text = produtos.data[indexPath.row].nome
                cell.precoDeLbl.attributedText = "De:\(produtos.data[indexPath.row].precoDe)".strikeThrough()
                let roundPreco = String(format:"%.2f",produtos.data[indexPath.row].precoPor)
                cell.precoPorLbl.text = "Por \(roundPreco)"
                let Image = produtos.data[indexPath.row].urlImagem
                if let image = URL(string: Image){
                    cell.ProductListImageView.kf.indicatorType = .activity
                    cell.ProductListImageView.kf.setImage(with: image)
                }
            }
            
            return cell
            
        } else {
            return UITableViewCell()
        }
    }
}

extension ProductsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                if arrayProductsList.isEmpty{}else{
                    let product = arrayProductsList[0].data[indexPath.row]
                    let request = Products.DetailProduct.Request(product: [product])
                    interactor?.doLoadDetailProducts(request: request)
                }
    }
}
