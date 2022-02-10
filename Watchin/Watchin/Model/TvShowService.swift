//
//  TvShowService.swift
//  Watchin
//
//  Created by Archeron on 10/02/2022.
//

import Foundation

class TvShowService {

    // MARK: - Properties

    private let baseUrl = "https://www.episodate.com/api/"

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
