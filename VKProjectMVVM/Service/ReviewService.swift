//
//  ReviewService.swift
//  VKProjectMVVM
//
//  Created by Berkay ÇAKMAK on 10.04.2022.
//

import Foundation

//MARK: - Protocols for review service

protocol ReviewServiceProtocol {
    func submitReview(review: Review,completion: @escaping ((Result<Review, APIError>) -> Void))
    func getReviews(productId:String, completion: @escaping ((Result<[Review],APIError>) -> Void))
}

class ReviewService : ReviewServiceProtocol {
    
    private let baseURL = "http://localhost:3002"
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    private enum EndPoint : String {
        case productList = "/reviews"
    }
    
    private enum Method: String {
        case GET
        case POST
    }
    
    //MARK: - Function that getting reviews for a productId
    
    func getReviews(productId:String, completion: @escaping ((Result<[Review],APIError>) -> Void)) {
        let endpoint :EndPoint = .productList
        let path = "\(baseURL)\(endpoint.rawValue)/\(productId)"
        let method = Method.GET
        guard let url = URL(string: path) else {
            completion(.failure(.internalError))
            return
        }
        print(url.absoluteURL)
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        dataTask = defaultSession.dataTask(with: request) { [weak self] data, response, error in
            defer {
                self?.dataTask = nil
            }
            
            if let error = error {
                completion(.failure(.serverError(error.localizedDescription)))
            } else if let data = data {

                let decoder = JSONDecoder()
                do {
                    let review = try decoder.decode([Review].self, from: data)
                    completion(.success(review))
                } catch {
                    completion(.failure(.parsingError))
                }
            }
        }
        
        dataTask?.resume()
    }
    
    //MARK: - Function that submits a new review on a product
    
    func submitReview(review: Review,completion: @escaping ((Result<Review, APIError>) -> Void)) {
        let endpoint :EndPoint = .productList
        let path = "\(baseURL)\(endpoint.rawValue)/\(review.productId)"
        let method = Method.POST
        guard let url = URL(string: path) else {
            completion(.failure(.internalError))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpBody = review.asJson
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = method.rawValue
        
        dataTask = defaultSession.dataTask(with: request) { [weak self] data, response, error in
            defer {
                self?.dataTask = nil
            }
            
            if let error = error {
                completion(.failure(.serverError(error.localizedDescription)))
            } else if let data = data {
                if let dataString = String(data: data, encoding: .utf8) {

                    print("Response data string:\n \(dataString)")

                }
                let decoder = JSONDecoder()
                do {
                    let review = try decoder.decode(Review.self, from: data)
                    completion(.success(review))
                } catch {
                    completion(.failure(.parsingError))
                }
            }
        }
        
        dataTask?.resume()
    }
    
    
}
