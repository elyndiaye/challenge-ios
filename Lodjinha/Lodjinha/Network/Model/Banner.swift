//
//  Banner.swift
//  Lodjinha
//
//  Created by ely.assumpcao.ndiaye on 17/06/19.
//  Copyright © 2019 ely.assumpcao.ndiaye. All rights reserved.
//

import Foundation

//   let banner = try? newJSONDecoder().decode(Banner.self, from: jsonData)


// MARK: - Banner
struct Banner: Codable {
    let data: [Data]
}

// MARK: - Datum
struct Data: Codable {
    let id: Int
    let urlImagem, linkUrl: String
    
}
