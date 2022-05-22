//
//  Product.swift
//  VKProjectMVVM
//
//  Created by Berkay ÇAKMAK on 10.04.2022.
//

import Foundation

struct Product: Codable {
    var id: String?
    var name: String?
    var description: String?
    var imgUrl: String?
    var price: Float?
    var reviews : [Review]?
    var currency: String?
    var ok : String?
}
