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
    
    
    //user: String, pass: String
    func loginUser(user: String, pass: String, completionHandler: @escaping ([Banner]) -> Void ) {
        
        let parameters = [
            "user": user,
            "password": pass
        ]
        
        print("Entrou no loginUser")
        
        let arrayUserAccounts = [Banner]()
        
        Alamofire.request(BASE_URL, method: .post, parameters: parameters, encoding:  URLEncoding.httpBody).responseJSON { (response:DataResponse<Any>) in
            
            if response.result.error == nil {
                guard let data = response.data else { return }
                print(response.result.value)
                
                do {
                    let decoder = JSONDecoder()
                    //            let decodedUserAcconts = try decoder.decode(UserAccount.self, from: data)
                    //             print(decodedUserAcconts.userAccount.userId)
                    
                    // let userAccount = try? newJSONDecoder().decode(UserAccount.self, from: jsonData)
                    
                    //              completionHandler([decodedUserAcconts])
                    //   print(completionHandler(decodedUserAcconts))
                } catch let error {
                    print(error)
                    completionHandler(arrayUserAccounts)
                    debugPrint(response.result.error as Any)
                }
                
                //completion(true)
            } else {
                //  completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    
    func getBanners(completionHandler: @escaping ([Banner]) -> Void ) {
        Alamofire.request(URL_BANNER, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { (response:DataResponse<Any>) in
            
            let arrayBanners = [Banner]()
            
            if response.result.error == nil {
                guard let data = response.data else { return }
                print(response.result.value)
                
                do {
                    let decoder = JSONDecoder()
                    let decodedBanners = try decoder.decode(Banner.self, from: data)
                    
                    //print(decodedBanners)
                    //print(decodedStatements.statementList[0].title,.data[0].urlImagem)
                    
                    
                    completionHandler([decodedBanners])
                    //completion(true)
                    //   print(completionHandler(decodedUserAcconts))
                } catch let error {
                    print(error)
                    completionHandler(arrayBanners)
                    debugPrint(response.result.error as Any)
                }
            } else {
                //  completion(false)
                debugPrint(response.result.error as Any)
            }
            
        } // FIM DA
        
    }
    
    func getCategory(completionHandler: @escaping ([Categoria]) -> Void ) {
        Alamofire.request(URL_CATEGORIA, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { (response:DataResponse<Any>) in
            
            let arrayCategories = [Categoria]()
            
            if response.result.error == nil {
                guard let data = response.data else { return }
                print(response.result.value)
                
                do {
                    let decoder = JSONDecoder()
                    let decodedCategories = try decoder.decode(Categoria.self, from: data)
                    
                    //print(decodedCategories)
                    //print(decodedStatements.statementList[0].title,.data[0].urlImagem)
                    
                    
                    completionHandler([decodedCategories])
                    //completion(true)
                    //   print(completionHandler(decodedUserAcconts))
                } catch let error {
                    print(error)
                    completionHandler(arrayCategories)
                    debugPrint(response.result.error as Any)
                }
            } else {
                //  completion(false)
                debugPrint(response.result.error as Any)
            }
            
        } // FIM DA
    }
    
    func getMoreSales(completionHandler: @escaping ([ProdutosMaisVendidos]) -> Void ) {
        Alamofire.request(URL_PRODUTO_MAISVENDIDOS, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { (response:DataResponse<Any>) in
            
            let arrayProdutosMaisVendidos = [ProdutosMaisVendidos]()
            
            if response.result.error == nil {
                guard let data = response.data else { return }
                print(response.result.value)
                
                do {
                    let decoder = JSONDecoder()
                    let decodedProdutosMaisVendidos = try decoder.decode(ProdutosMaisVendidos.self, from: data)
                    
                    // print(decodedProdutosMaisVendidos)
                    print(decodedProdutosMaisVendidos.data[0].nome)
                    
                    
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
            
        } // FIM DA
    }
    
}
