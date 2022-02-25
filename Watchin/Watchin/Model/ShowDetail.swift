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
    // Formatting properties to conform to ShowDetailProtocol, and obtain correct forms of it to use in controllers :

    var idFormatted: Int {
        return id
    }

    var nameFormatted: String {
        return name
    }

    var countryFormatted: String {
        return "Country: \(country)"
    }

    var statusFormatted: String {
        return "Status: \(status)"
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
        let date = String(startDate.prefix(4))
        return "(\(date))"
    }

    var genresFormatted: String {
        return genres.joined(separator: ", ")
    }

    var numberOfSeasons: String {
        let seasonNumber = episodes.map{$0.season}.max() ?? 0
        if seasonNumber == 1 {
            return "\(seasonNumber) Season"
        } else {
            return "\(seasonNumber) Seasons"
        }
    }

    var numberOfEpisodes: String {
        let numberOfEpisodesFormatted = String(episodes.count)
        return numberOfEpisodesFormatted
    }

    var watchedSeasonsFormatted: Int {
        return 0
    }

    var watchedEpisodesFormatted: Int {
        return 0
    }

    var platformFormatted: String {
        return "add platform"
    }
}

extension EpisodeInfo: EpisodeFormatted {
    // Formatting properties to conform to EpisodeFormatted:
    
    var episodeNameFormatted: String {
        return name
    }

    var episodeNumberFormatted: Int {
        return episode
    }

    var seasonNumberFormatted: Int {
        return season
    }

    var hasBeenWatchedFormatted: Bool {
        return false
    }


}
