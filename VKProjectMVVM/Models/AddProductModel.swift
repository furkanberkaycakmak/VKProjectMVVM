//
//  AddProductModel.swift
//  VKProjectMVVM
//
//  Created by Berkay ÇAKMAK on 11.05.2022.
//

import Foundation

struct AddProductRequest: Codable {
    var id: String?
    var name: String?
    var description: String?
    var imgUrl: String?
}

struct AddProductResponse: Decodable {
    var id: String?
    var name: String?
    var description: String?
    var imgUrl: String?
    var _id: String?
}
