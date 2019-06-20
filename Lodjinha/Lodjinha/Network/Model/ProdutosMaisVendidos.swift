//
//  Produto.swift
//  Lodjinha
//
//  Created by ely.assumpcao.ndiaye on 17/06/19.
//  Copyright © 2019 ely.assumpcao.ndiaye. All rights reserved.
//

//   let produtosMaisVendidos = try? newJSONDecoder().decode(ProdutosMaisVendidos.self, from: jsonData)

import Foundation

// MARK: - ProdutosMaisVendidos
struct ProdutosMaisVendidos: Codable {
    let data: [DataProdutosMaisVendidos]
    //let offset, total: Int
}

// MARK: - Datum
struct DataProdutosMaisVendidos: Codable {
    let id: Int
    let nome: String
    let urlImagem: String
    let descricao: String
    let precoDe: Int
    let precoPor: Double
    let categoria: CategoriaProdutosMaisVendidos
}

// MARK: - Categoria
struct CategoriaProdutosMaisVendidos: Codable {
    let descricao: String
    let id: Int
    let urlImagem: String
}
