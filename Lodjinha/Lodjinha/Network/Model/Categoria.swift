//
//  Categoria.swift
//  Lodjinha
//
//  Created by ely.assumpcao.ndiaye on 17/06/19.
//  Copyright © 2019 ely.assumpcao.ndiaye. All rights reserved.
//

//   let categoria = try? newJSONDecoder().decode(Categoria.self, from: jsonData)

import Foundation

// MARK: - Categoria
struct Categoria: Codable {
    let data: [DataCategoria]
}

// MARK: - Datum
struct DataCategoria: Codable {
    let id: Int
    let descricao: String
    let urlImagem: String
}
