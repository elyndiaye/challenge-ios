//
//  HomeViewController.swift
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
import Kingfisher


protocol HomeDisplayLogic: class {
    
    func displayInitialDatas(viewModel: HomeScenes.Load.ViewModel)
    func displayDetailProduct(viewModel: HomeScenes.DetailProduct.ViewModel)
    func displayProductsList(viewModel: HomeScenes.ProductsList.ViewModel)
}

class HomeViewController: UIViewController, HomeDisplayLogic {
    
    
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var maisVendidosTableView: UITableView!
    
    
    @IBOutlet weak var pageView: UIPageControl!
    
    
    var interactor: HomeBusinessLogic?
    var router: (NSObjectProtocol & HomeRoutingLogic & HomeDataPassing)?
    var bannerArray = [  UIImage(named:"Alexandra Daddario"),
                         UIImage(named:"Angelina Jolie") ,
                         UIImage(named:"Anne Hathaway") ]
    var arrayBanners = [Banner]()
    var arrayCategories = [Categoria]()
    var arrayProdutosMaisVendidos = [ProdutosMaisVendidos]()
    
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
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        let router = HomeRouter()
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
        self.tabBarController?.tabBar.isHidden = false
        loadInitalData()
    }
    
    override func viewDidLoad() {
        self.tabBarController?.tabBar.isHidden = false
        super.viewDidLoad()
        
        addNavBarImage()
        // loadInitalData()
        
        pageView.numberOfPages = bannerArray.count
        pageView.currentPage = 0
        
        
        bannerCollectionView.dataSource = self
        bannerCollectionView.delegate = self
        
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        
        maisVendidosTableView.delegate = self
        maisVendidosTableView.dataSource = self
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // self.tabBarController?.tabBar.isHidden = true
    }
    
    func addNavBarImage() {
        let logo = UIImage(named: "logoNavbar_2")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView }
    
    // MARK: Do something
    
    //@IBOutlet weak var nameTextField: UITextField!
    
    func loadInitalData()
    {
        let request = HomeScenes.Load.Request()
        interactor?.doLoadInitialData(request: request)
    }
    
    func displayInitialDatas(viewModel: HomeScenes.Load.ViewModel)
    {
        //nameTextField.text = viewModel.name
        arrayBanners = viewModel.banners
        arrayCategories = viewModel.categories
        arrayProdutosMaisVendidos = viewModel.produtosMaisVendidos
        
        DispatchQueue.main.async {
            self.bannerCollectionView.reloadData()
        }
        
        DispatchQueue.main.async {
            self.categoryCollectionView.reloadData()
        }
        
        DispatchQueue.main.async {
            self.maisVendidosTableView.reloadData()
        }
        
    }
    
    func displayDetailProduct(viewModel: HomeScenes.DetailProduct.ViewModel) {
        router?.routeToDetailProduct()
    }
    
    func displayProductsList(viewModel: HomeScenes.ProductsList.ViewModel) {
        router?.routeToProductsList()
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count = 3
        if collectionView == self.categoryCollectionView {
            if arrayCategories.isEmpty{
                count = 3
            }else {
                count = arrayCategories[0].data.count
            }
        }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.bannerCollectionView {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bannerCell", for: indexPath) as? BannerCell {
                
                if arrayBanners.isEmpty{
                    cell.bannerImage.kf.indicatorType = .activity
                    cell.bannerImage.kf.setImage(with: URL(string: "https://gph.is/1XRTmuh")!)   }
                else {
                    let banner = arrayBanners[0]
                    let Image = banner.data[indexPath.row].urlImagem
                    if let image = URL(string: Image){
                        cell.bannerImage.kf.indicatorType = .activity
                        cell.bannerImage.kf.setImage(with: image)
                    }
                }
                return cell
            }
            else {
                return BannerCell()
            }
        }
        
        if collectionView == self.categoryCollectionView {
            
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as? CategoryCell {
                
                if arrayCategories.isEmpty{
                    cell.categoryImageView.kf.indicatorType = .activity
                    cell.categoryImageView.kf.setImage(with: URL(string: "https://gph.is/1XRTmuh")!)   }
                else {
                    let category = arrayCategories[0]
                    cell.descricaoLbl.text =  category.data[indexPath.row].descricao
                    let Image = category.data[indexPath.row].urlImagem
                    if let image = URL(string: Image){
                        cell.categoryImageView.kf.indicatorType = .activity
                        cell.categoryImageView.kf.setImage(with: image)
                    }
                    
                }
                return cell
            }
            else {
                return CategoryCell()
            }
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.categoryCollectionView {
            if arrayCategories.isEmpty{}else{
                let categoria = arrayCategories[0].data[indexPath.row]
                let request = HomeScenes.ProductsList.Request(categoria: [categoria])
                interactor?.doLoadProductsList(request: request)
            }
        }
        
    }
    
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == self.bannerCollectionView {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) }
        else { return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0) }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.bannerCollectionView {
            let size = bannerCollectionView.frame.size
            return CGSize(width: size.width, height: size.height) }
        else {
            return CGSize(width: 100, height: 115 ) }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.bannerCollectionView {
            return 0.0 }
        else {  return 10.10  }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: self.bannerCollectionView.contentOffset, size: self.bannerCollectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        if let visibleIndexPath = self.bannerCollectionView.indexPathForItem(at: visiblePoint) {
            self.pageView.currentPage = visibleIndexPath.row
        }
    }
    
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 2
        if arrayCategories.isEmpty{
            count = 2
        }else {
            count = arrayProdutosMaisVendidos[0].data.count
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier:"productCell", for: indexPath) as? ProductCell {
            
            if arrayProdutosMaisVendidos.isEmpty{
                cell.productImageView.kf.indicatorType = .activity
                cell.productImageView.kf.setImage(with: URL(string: "https://gph.is/1XRTmuh")!)   }
            else {
                
                let maisVendidos = arrayProdutosMaisVendidos[0]
                cell.productLbl.text = maisVendidos.data[indexPath.row].nome
                cell.precoDe.attributedText = "De:\(maisVendidos.data[indexPath.row].precoDe)".strikeThrough()
                let roundPreco = String(format:"%.2f",maisVendidos.data[indexPath.row].precoPor)
                cell.precoPor.text = "Por \(roundPreco)"
                let Image = maisVendidos.data[indexPath.row].urlImagem
                if let image = URL(string: Image){
                    cell.productImageView.kf.indicatorType = .activity
                    cell.productImageView.kf.setImage(with: image)
                }
            }
            
            return cell
            
        } else {
            return UITableViewCell()
        }
    }
}

extension HomeViewController: UITableViewDelegate {
    //Implementando o Clique do botao
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if arrayProdutosMaisVendidos.isEmpty{}else{
            let product = arrayProdutosMaisVendidos[0].data[indexPath.row]
            let request = HomeScenes.DetailProduct.Request(product: [product])
            interactor?.doLoadDetailProducts(request: request)
        }
    }
}

extension String {
    func strikeThrough() -> NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0,attributeString.length))
        return attributeString
    }
}
