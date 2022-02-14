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
    var name: String
    var description: String
    var descriptionSource: String?
    var startDate: String
    var country: String
    var status: String
    var imageStringUrl: String
    var genres: [String]
    var episodes: [EpisodeInfo]

    // setting coding keys to custom property names :
    private enum CodingKeys: String, CodingKey {
        case id, name, description, descriptionSource = "description_source", startDate = "start_date", country, status, imageStringUrl = "image_thumbnail_path", genres, episodes
    }
}

struct EpisodeInfo: Decodable {
    var season: Int
    var episode: Int
    var name: String
}
