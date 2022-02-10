//
//  TvShowService.swift
//  Watchin
//
//  Created by Archeron on 10/02/2022.
//

import Foundation

class TvShowService {

    // MARK: - Properties

    private let networkService: NetworkProtocol
    private let baseUrl = "https://www.episodate.com/api/"

    // MARK: - Init

    init(networkService: NetworkProtocol = NetworkService()) {
        self.networkService = networkService
    }

    // MARK: - getSearchResults

    func getSearchResults(searchText: String?, completion: @escaping (Result<[TvShowsSearchDetail], Error>) -> Void) {
        let baseUrl = computeShowDetailsQuery()

        networkService.request(baseURL: baseUrl) { (result: Result<SearchResult, Error>) in
            switch result {
            case .success(let searchResult):
                let tvShows = searchResult.tv_shows
                completion(.success(tvShows))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    // MARK: - Private

    private func computeSearchQuery(searchText: String?) -> String {
        guard let text = searchText else {
            return ""
        }
        return "\(baseUrl)search?q=\(text)&page=1"
    }

    private func computeShowDetailsQuery() -> String {
        // à compléter
        return ""
    }

}
