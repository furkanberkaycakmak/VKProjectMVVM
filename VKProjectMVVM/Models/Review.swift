//
//  Review.swift
//  VKProjectMVVM
//
//  Created by Berkay ÇAKMAK on 10.04.2022.
//

import Foundation

struct Review: Codable {
    var rating: Int?
    var text: String?
    var locale: String?
    var productId: String
}


