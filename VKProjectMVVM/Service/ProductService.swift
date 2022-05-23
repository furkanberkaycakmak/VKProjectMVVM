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
    func deleteProduct(id:String, completion: @escaping ((Result<DeleteProductResponse,APIError>) -> Void))
    func addProduct(model: AddProductRequest ,completion: @escaping ((Result<[AddProductResponse], APIError>) -> Void))
}

//MARK: - ProductService class

class ProductService : ProductServiceProtocol {
    
    func deleteProduct(id:String, completion: @escaping ((Result<DeleteProductResponse,APIError>) -> Void)) {
        let endpoint :EndPoint = .productList
        let path = "\(baseURL)\(endpoint.rawValue)/\(id)"
        let method = Method.DELETE
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
                    let deleted = try decoder.decode(DeleteProductResponse.self, from: data)
                    completion(.success(deleted))
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
        case DELETE
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
    
    //MARK: - Function that adds a product on database
    
    
    func addProduct(model: AddProductRequest ,completion: @escaping ((Result<[AddProductResponse], APIError>) -> Void)) {
        let endpoint :EndPoint = .productList
        let path = "\(baseURL)\(endpoint.rawValue)"
        guard let url = URL(string: path) else {
            completion(.failure(.internalError))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonBody = try JSONEncoder().encode(model)
            request.httpBody = jsonBody
            print("jsonBody:",jsonBody)
            let jsonBodyString = String(data: jsonBody, encoding: .utf8)
            print("JSON String : ", jsonBodyString!)
        } catch let err  {
            print("jsonBody Error: ",err)
        }
        dataTask = defaultSession.dataTask(with: request) { [weak self] data, response, error in
            defer {
                self?.dataTask = nil
            }
            
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(.serverError(error.localizedDescription)))
            } else if let data = data {
                
                let decoder = JSONDecoder()
                
                do {
                    let products = try decoder.decode([AddProductResponse].self, from: data)
                    completion(.success(products))
                } catch {
                    completion(.failure(.parsingError))
                }
            }
        }
        
        dataTask?.resume()
    }
    
}
