//
//  ProdutoById.swift
//  Lodjinha
//
//  Created by ely.assumpcao.ndiaye on 21/06/19.
//  Copyright © 2019 ely.assumpcao.ndiaye. All rights reserved.
//

//   let produtosMaisVendidos = try? newJSONDecoder().decode(ProdutosMaisVendidos.self, from: jsonData)

import Foundation

// MARK: - ProdutosByID
struct ProdutosById: Codable {
    let id: Int
    let nome: String
    let urlImagem: String
    let descricao: String
    let precoDe: Int
    let precoPor: Double
    let categoria: CategoriaProdutoById
}

// MARK: - Categoria
struct CategoriaProdutoById: Codable {
    let id: Int
    let descricao: String
    let urlImagem: String
}
