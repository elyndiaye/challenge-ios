//
//  Produtos.swift
//  Lodjinha
//
//  Created by ely.assumpcao.ndiaye on 20/06/19.
//  Copyright © 2019 ely.assumpcao.ndiaye. All rights reserved.
//

//   let produtos = try? newJSONDecoder().decode(Produtos.self, from: jsonData)

import Foundation

// MARK: - Produtos
struct Produtos: Codable {
    let data: [DataProdutos]
    let offset, total: Int
}

// MARK: - Datum
struct DataProdutos: Codable {
    
    let id: Int
    let nome: String
    let urlImagem: String
    let descricao: String
    let precoDe: Int
    let precoPor: Double
    let categoria: CategoriaProdutos
}

// MARK: - Categoria
struct CategoriaProdutos: Codable {
    let descricao: String
    let id: Int
    let urlImagem: String
}
