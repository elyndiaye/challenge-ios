//
//  NetworkManeger.swift
//  Lodjinha
//
//  Created by ely.assumpcao.ndiaye on 17/06/19.
//  Copyright © 2019 ely.assumpcao.ndiaye. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func getBanners(completionHandler: @escaping ([Banner]) -> Void ) {
        Alamofire.request(URL_BANNER, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { (response:DataResponse<Any>) in
            
            let arrayBanners = [Banner]()
            
            if response.result.error == nil {
                guard let data = response.data else { return }
                
                do {
                    let decoder = JSONDecoder()
                    let decodedBanners = try decoder.decode(Banner.self, from: data)
                    
                    completionHandler([decodedBanners])
                } catch let error {
                    print(error)
                    completionHandler(arrayBanners)
                    debugPrint(response.result.error as Any)
                }
            } else {
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func getCategory(completionHandler: @escaping ([Categoria]) -> Void ) {
        Alamofire.request(URL_CATEGORIA, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { (response:DataResponse<Any>) in
            
            let arrayCategories = [Categoria]()
            
            if response.result.error == nil {
                guard let data = response.data else { return }
                
                do {
                    let decoder = JSONDecoder()
                    let decodedCategories = try decoder.decode(Categoria.self, from: data)
                    
                    //print(decodedCategories)
                    //print(decodedStatements.statementList[0].title,.data[0].urlImagem)
                    
                    
                    completionHandler([decodedCategories])
                    //   print(completionHandler(decodedUserAcconts))
                } catch let error {
                    print(error)
                    completionHandler(arrayCategories)
                    debugPrint(response.result.error as Any)
                }
            } else {
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func getMoreSales(completionHandler: @escaping ([ProdutosMaisVendidos]) -> Void ) {
        Alamofire.request(URL_PRODUTO_MAISVENDIDOS, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { (response:DataResponse<Any>) in
            
            let arrayProdutosMaisVendidos = [ProdutosMaisVendidos]()
            
            if response.result.error == nil {
                guard let data = response.data else { return }
                
                do {
                    let decoder = JSONDecoder()
                    let decodedProdutosMaisVendidos = try decoder.decode(ProdutosMaisVendidos.self, from: data)
                    
                    completionHandler([decodedProdutosMaisVendidos])
                    //completion(true)
                    //   print(completionHandler(decodedUserAcconts))
                } catch let error {
                    print(error)
                    completionHandler(arrayProdutosMaisVendidos)
                    debugPrint(response.result.error as Any)
                }
            } else {
                //  completion(false)
                debugPrint(response.result.error as Any)
            }
            
        }
    }
    
    func getProductByCategoryId(withCategoryId categoryId: String, completionHandler: @escaping ([Produtos]) -> Void ) {
        print("\(URL_PRODUTO)?limit=20&categoriaId=\(categoryId)")
        Alamofire.request("\(URL_PRODUTO)?limit=20&categoriaId=\(categoryId)", method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { (response:DataResponse<Any>) in
            print("ProductByCategoryId")
            let arrayProdutoByCategoryId = [Produtos]()
            
            if response.result.error == nil {
                guard let data = response.data else { return }
                
                do {
                    let decoder = JSONDecoder()
                    let decodedProdutoByCategoryId = try decoder.decode(Produtos.self, from: data)
                    print(decodedProdutoByCategoryId)
                    completionHandler([decodedProdutoByCategoryId])
                } catch let error {
                    print(error)
                    completionHandler(arrayProdutoByCategoryId)
                    debugPrint(response.result.error as Any) }
            } else {
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    
    func getProductById(withProductId productId: String, completionHandler: @escaping ([ProdutosById]) -> Void ) {
        Alamofire.request("\(URL_PRODUTO)/\(productId)", method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { (response:DataResponse<Any>) in
            print("ProductById")
            let arrayProdutoById = [ProdutosById]()
            
            if response.result.error == nil {
                guard let data = response.data else { return }
                
                do {
                    let decoder = JSONDecoder()
                    let decodedProdutoById = try decoder.decode(ProdutosById.self, from: data)
                    print(decodedProdutoById.id)
                    completionHandler([decodedProdutoById])
                } catch let error {
                    print(error)
                    completionHandler(arrayProdutoById)
                    debugPrint(response.result.error as Any) }
            } else {
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func reserveProduct(withProductId productId: String, completion: @escaping CompletionHandler) {
        
        print("Entrou no reservaer")
        
        Alamofire.request("\(URL_PRODUTO)/\(productId)", method: .post, parameters: nil, encoding:  URLEncoding.httpBody).responseJSON { (response:DataResponse<Any>) in
            
            if response.result.error == nil {
                guard let data = response.data else { return }
                print(response.result.value)
                do {
                    print("Passou")
                    completion(true, "OK")
                } catch let error {
                    print(error)
                    // completionHandler(arrayUserAccounts)
                    debugPrint(response.result.error as Any)
                    completion(false, "Não foi possivel reservar o produto.")
                }
                
            } else {
                debugPrint(response.result.error as Any)
                if let error = response.result.error as NSError?, error.domain == NSURLErrorDomain && error.code == NSURLErrorNotConnectedToInternet {
                    completion(false, "A network error has occurred. Check your Internet connection and try again later.")
                    print(error)
                }
                completion(false, "Não foi possivel reservar o produto")
                print(response.response?.statusCode as Any)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
}
