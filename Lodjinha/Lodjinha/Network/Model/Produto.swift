//
//  Produto.swift
//  Lodjinha
//
//  Created by ely.assumpcao.ndiaye on 17/06/19.
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
    let categoria: CategoriaProduto
    let descricao: String
    let id: Int
    let nome: String
    let precoDe, precoPor: Int
    let urlImagem: String
}

// MARK: - Categoria
struct CategoriaProduto: Codable {
    let descricao: String
    let id: Int
    let urlImagem: String
}
