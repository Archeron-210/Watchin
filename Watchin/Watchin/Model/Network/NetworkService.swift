//
//  NetworkService.swift
//  Watchin
//
//  Created by Archeron on 10/02/2022.
//

import Foundation
import Alamofire

// MARK: - Network Protocol
// The protocol used in application and in unit tests

protocol NetworkProtocol: AnyObject {
    func request<T: Decodable>(baseURL: String, completion: @escaping (Result<T, Error>) -> Void)
}

// MARK: - Network Service
// allows to create a layer between Alamofire and the application

class NetworkService: NetworkProtocol {
    func request<T: Decodable>(baseURL: String, completion: @escaping (Result<T, Error>) -> Void) {
        AF.request(baseURL).responseDecodable(of: T.self) { (response) in
            switch response.result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
