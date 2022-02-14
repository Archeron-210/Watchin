//
//  ShowDetail.swift
//  Watchin
//
//  Created by Archeron on 14/02/2022.
//

import Foundation

// MARK: - Data Mapping From API JSON Response

struct ShowDetail: Decodable {
    var tvShow: TvShowInfo
}

struct TvShowInfo: Decodable {
    var id: Int
    var description: String
    var description_source: String?
    var start_date: String
    var country: String
    var status: String
    var genres: [String]
    var episodes: [EpisodeInfo]
}

struct EpisodeInfo: Decodable {
    var season: Int
    var episode: Int
    var name: String
}
