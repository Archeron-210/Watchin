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

    // MARK: - getSearchResults & getShowDetails

    func getSearchResults(searchText: String?, completion: @escaping (Result<[TvShowsSearchDetail], Error>) -> Void) {
        let baseUrl = computeSearchBaseUrl(searchText: searchText)

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

    func getShowDetails(for showName: String, completion: @escaping (Result<TvShowInfo, Error>) -> Void) {
        let baseUrl = computeShowDetailsBaseUrl(for: showName)

        networkService.request(baseURL: baseUrl) { (result: Result<ShowDetail, Error>) in
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

    private func computeSearchBaseUrl(searchText: String?) -> String {
        guard let text = searchText, let escapedText = escapeWhitespaces(for: text) else {
            return ""
        }

        return "\(baseUrl)search?q=\(escapedText)&page=1"
    }

    private func computeShowDetailsBaseUrl(for tvShowName: String) -> String {
        // à compléter
        return "\(baseUrl)show-details?q=\(tvShowName)"
    }

    private func escapeWhitespaces(for text: String) -> String? {
        return text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
}
