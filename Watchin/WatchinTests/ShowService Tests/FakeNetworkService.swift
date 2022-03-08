//
//  FakeNetworkService.swift
//  WatchinTests
//
//  Created by Archeron on 08/03/2022.
//

import Foundation
@testable import Watchin

class FakeNetworkService: NetworkProtocol {
    func request<T>(baseURL: String, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        let bundle = Bundle(for: FakeNetworkService.self)
        let url = bundle.url(forResource: baseURL, withExtension: "json")!
        do {
            let jsonData = try Data(contentsOf: url)
            let decodedData: T = try JSONDecoder().decode(T.self, from: jsonData)
            completion(.success(decodedData))
        } catch {
            completion(.failure(error))
        }
    }
}

class FakeConfiguration {

    static var correctSearchResults: ApiConfiguration {
        return ApiConfiguration(baseUrl: "CorrectSearchResults")
    }
    static var correctShowDetails: ApiConfiguration {
        return ApiConfiguration(baseUrl: "CorrectShowDetails")
    }
    static var incorrect: ApiConfiguration {
        return ApiConfiguration(baseUrl: "Incorrect")
    }
}
