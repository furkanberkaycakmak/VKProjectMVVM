//
//  ProductService.swift
//  VKProjectMVVM
//
//  Created by Berkay ÇAKMAK on 10.04.2022.
//

import Foundation

//MARK: -API error handler and switcher

enum APIError: Error {
    case internalError
    case serverError(String)
    case parsingError
}

extension APIError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .serverError(let desc):
            return "Server Error: " + desc
        case .internalError:
            return "Internal Error: "
        case .parsingError:
            return "Parsing Error: "
        }
    }
}

//MARK: -Protocols for product service

protocol ProductServiceProtocol {
    func getProducts(completion: @escaping((Result<[Product],APIError>) -> Void))
    //func deleteProduct(id: String, completion: @escaping((Result<GenericResponse>) -> Void))
}


class ProductService : ProductServiceProtocol {
    func deleteProduct(id: String, completion: @escaping ((Result<Product, APIError>) -> Void)) {
            let endpoint :EndPoint = .productList
            let path = "\(baseURL)\(endpoint.rawValue)/\(id)"
            let method = Method.DEL
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
                        let product = try decoder.decode(Product.self, from: data)
                        completion(.success(product))
                    } catch {
                        completion(.failure(.parsingError))
                    }
                }
            }
            
            dataTask?.resume()
        }
    
    
    private let baseURL = "http://localhost:3001"
    let defaultSession = URLSession(configuration: .ephemeral)
    var dataTask: URLSessionDataTask?
    private enum EndPoint : String {
        case productList = "/product"
    }
    
    private enum Method: String {
        case GET
        case DEL
    }
    
    //MARK: - Function that calls every product on database
    
    func getProducts(completion: @escaping ((Result<[Product], APIError>) -> Void)) {
        let endpoint :EndPoint = .productList
        let path = "\(baseURL)\(endpoint.rawValue)"
        guard let url = URL(string: path) else {
            completion(.failure(.internalError))
            return
        }
        
        dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
            defer {
                self?.dataTask = nil
            }
            
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(.serverError(error.localizedDescription)))
            } else if let data = data {
                
                let decoder = JSONDecoder()
                
                do {
                    let products = try decoder.decode([Product].self, from: data)
                    completion(.success(products))
                } catch {
                    completion(.failure(.parsingError))
                }
            }
        }
        
        dataTask?.resume()
    }
    
}
