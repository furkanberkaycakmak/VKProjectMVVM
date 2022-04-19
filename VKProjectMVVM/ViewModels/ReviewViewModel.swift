//
//  ReviewViewModel.swift
//  VKProjectMVVM
//
//  Created by Berkay ÇAKMAK on 10.04.2022.
//

import Foundation


class ReviewViewModel {
    var reviews : [Review] = []
    var service : ReviewServiceProtocol
    var productId : String
    
    init(productId : String, service: ReviewServiceProtocol) {
        self.service = service
        self.productId = productId
    }
    
    func getReviews(completion: @escaping (Bool, String?) -> Void) {
        service.getReviews(productId: productId) { (res) in
            switch res{
            case .success(let reviews):
                self.reviews = reviews
                completion(true, nil)
            case .failure(let error):
                print(error)
                completion(false, error.localizedDescription)
            }
        }
    }
    
    func submitReview(review: Review, completion: @escaping (Bool, Review?, String?) -> Void){
        service.submitReview(review: review, completion: { (res) in
            
            switch res{
            case .success(let review):
                completion(true,review, nil)
            case .failure(let error):
                completion(false, nil, error.localizedDescription)
            }
            DispatchQueue.main.async {
                
            }
            
        })
    }
    
}
