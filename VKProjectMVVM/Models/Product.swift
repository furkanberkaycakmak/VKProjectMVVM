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
    
    
    func getOverallRating() -> String {
        guard let reviews = self.reviews,
            reviews.count != 0 else
        {
            return "0"
        }
        let allRatings = reviews.map({$0.rating})
        let sum = allRatings.reduce(0) { (var1, var2)  in
            return var1 + (var2 ?? 0)
        }
        
        return String(sum/allRatings.count)
    }
}
