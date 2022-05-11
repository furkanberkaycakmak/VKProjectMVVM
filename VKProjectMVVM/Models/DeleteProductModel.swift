//
//  DeleteProductModel.swift
//  VKProjectMVVM
//
//  Created by Berkay ÇAKMAK on 11.05.2022.
//

import Foundation

struct DeleteProductRequest: Codable {
    var id: String?
}

struct DeleteProductResponse: Decodable {
    var ok: Int?
}
