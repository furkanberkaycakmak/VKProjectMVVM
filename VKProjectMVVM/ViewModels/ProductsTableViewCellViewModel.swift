//
//  Functions.swift
//  VKProjectMVVM
//
//  Created by Berkay ÇAKMAK on 21.05.2022.
//

import Foundation

//MARK: - Function that gets overall rating for product
class ProductsTableViewCellViewModel {
    func getOverallRating(reviews : [Review]?) -> String {
        guard let reviews = reviews,
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

