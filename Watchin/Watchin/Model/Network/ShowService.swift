//
//  TvShowService.swift
//  Watchin
//
//  Created by Archeron on 10/02/2022.
//

import Foundation

struct ApiConfiguration {

    let searchBaseURL: String
    let showDetailBaseURL: String

    init(searchBaseURL: String, showDetailBaseURL: String) {
        self.searchBaseURL = searchBaseURL
        self.showDetailBaseURL = showDetailBaseURL
    }

    init() {
        searchBaseURL = "https://www.episodate.com/api/search"
        showDetailBaseURL = "https://www.episodate.com/api/show-details"
    }
}

class ShowService {

    enum Route: String {
        case search
        case showDetails = "show-details"
    }

    // MARK: - Properties

    private let networkService: NetworkProtocol
    private let apiConfiguration: ApiConfiguration

    // MARK: - Init

    init(networkService: NetworkProtocol = NetworkService(), apiConfiguration: ApiConfiguration = ApiConfiguration()) {
        self.networkService = networkService
        self.apiConfiguration = apiConfiguration
    }

    // MARK: - getSearchResults & getShowDetails

    func getSearchResults(searchText: String?, completion: @escaping (Result<[ShowSearchDetail], Error>) -> Void) {
        let baseURL = apiConfiguration.searchBaseURL
        let parameters = computeSearchParameters(searchParameter: searchText)
        networkService.request(baseURL: baseURL, parameters: parameters) { (result: Result<SearchResult, Error>) in
            switch result {
            case .success(let searchResult):
                let tvShows = searchResult.tv_shows
                completion(.success(tvShows))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getShowDetails(for showName: String, completion: @escaping (Result<TvShowInfo, Error>) -> Void) {
        let baseURL = apiConfiguration.showDetailBaseURL
        let parameters = computeSearchParameters(searchParameter: showName)
        networkService.request(baseURL: baseURL, parameters: parameters) { (result: Result<ShowDetail, Error>) in
            switch result {
            case .success(let details):
                let showDetails = details.tvShow
                completion(.success(showDetails))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }


    // MARK: - Private

    private func computeSearchParameters(searchParameter: String?) -> [String: Any] {
        guard let text = searchParameter, let escapedText = escapeWhitespaces(for: text) else {
            return [:]
        }
        let parameters: [String: Any] = [
            "q": escapedText
        ]
        return parameters
    }

    private func escapeWhitespaces(for text: String) -> String? {
        return text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
}
