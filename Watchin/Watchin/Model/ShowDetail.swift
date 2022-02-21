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

extension TvShowInfo: ShowDetailFormatted {
    var idFormatted: Int {
        return id
    }

    var nameFormatted: String {
        return name
    }

    var countryFormatted: String {
        return country
    }

    var statusFormatted: String {
        return status
    }

    var imageStringUrlFormatted: String {
        return imageStringUrl
    }

    var descriptionFormatted: String {
        return description.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }

    var descriptionSourceFormatted: String {
        guard let descriptionSource = descriptionSource else {
            let formattedName = name.replacingOccurrences(of: " ", with: "+")
            return "https://www.google.com/search?q=\(formattedName)"
        }
        return descriptionSource
    }

    var startDateFormatted: String {
        // à compléter - changer
        return String(startDate.prefix(4))
    }

    var genresFormatted: String {
        return genres.joined(separator: ", ")
    }

    var numberOfSeasons: String {
        let seasonNumber = episodes.map{$0.season}.max() ?? 0
        let formattedSeasonNumber = String(seasonNumber)
        return formattedSeasonNumber
    }

    var numberOfEpisodes: String {
        let numberOfEpisodesFormatted = String(episodes.count)
        return numberOfEpisodesFormatted
    }

    var watchedSeasons: Int {
        return 0
    }

    var watchedepisodes: Int {
        return 0
    }

    var platform: String {
        return "add platform"
    }

    
}
