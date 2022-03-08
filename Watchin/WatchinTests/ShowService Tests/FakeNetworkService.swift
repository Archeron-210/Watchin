//
//  FakeNetworkService.swift
//  WatchinTests
//
//  Created by Archeron on 08/03/2022.
//

import Foundation
@testable import Watchin

class FakeNetworkService: NetworkProtocol {
    // implementing request from NetworkProtocol, this time by passing fake data through "baseUrl":
    func request<T>(baseURL: String, parameters: [String: Any], completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
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

    static var correct: ApiConfiguration {
        return ApiConfiguration(searchBaseURL: "CorrectSearchResults", showDetailBaseURL: "CorrectShowDetails")
    }
    static var incorrect: ApiConfiguration {
        return ApiConfiguration(searchBaseURL: "Incorrect", showDetailBaseURL: "Incorrect")
    }
}
