//
//  ProductViewModel.swift
//  VKProjectMVVM
//
//  Created by Berkay ÇAKMAK on 10.04.2022.
//

import Foundation

//MARK: - ViewModel class and initializers

class ProductViewModel {
    var products : [Product] = []
    var service : ProductServiceProtocol
    
    init(service: ProductServiceProtocol) {
        self.service = service
    }
    
    func getProducts(completion: @escaping (Bool, String?)->Void) {
        service.getProducts(completion: { [self] (res) in
            switch res {
            case .success(let products):
                self.products = products
                completion(true, nil)
            case .failure(let error):
                completion(false, error.localizedDescription)
            }
        })
    }
    
    

}
