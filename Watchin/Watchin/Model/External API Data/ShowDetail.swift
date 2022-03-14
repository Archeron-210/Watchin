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
    var startDate: String?
    var country: String
    var status: String
    var imageStringUrl: String
    var genres: [String]
    var episodes: [EpisodeInfo]

    // setting coding keys to customize property names :
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
    // Formatting properties to conform to ShowDetailProtocol, and obtain correct forms of it to use in controllers and later in CoreData :

    var idFormatted: Int {
        return id
    }
    var nameFormatted: String {
        guard name != "" else {
            return DefaultString.name
        }
        return name
    }
    var countryFormatted: String {
        guard country != "" else {
            return DefaultString.country
        }
        return "Country: \(country)"
    }
    var statusFormatted: String {
        guard status != "" else {
            return DefaultString.status
        }
        return status
    }
    var imageStringUrlFormatted: String {
        guard imageStringUrl != "" else {
            return DefaultString.stringUrl
        }
        return imageStringUrl
    }
    var descriptionFormatted: String {
        guard description != "", description != "<br>" else {
            return DefaultString.description
        }
        return description.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    var descriptionSourceFormatted: String {
        guard descriptionSource != "" else {
            return DefaultString.descriptionSource
        }
        guard let descriptionSource = descriptionSource else {
            let formattedName = name.replacingOccurrences(of: " ", with: "+")
            return "https://www.google.com/search?q=\(formattedName)"
        }
        return descriptionSource
    }
    var startDateFormatted: String {
        guard let date = startDate else {
            return DefaultString.date
        }
        var formattedDate = ""
        if date.hasAlphabeticalCharacters() {
            formattedDate = String(date.suffix(4))
        } else {
            formattedDate = String(date.prefix(4))
        }
        return "(\(formattedDate))"
    }
    var genresFormatted: String {
        guard genres != [] else {
            return DefaultString.genre
        }
        return genres.joined(separator: ", ")
    }
    var numberOfSeasons: String {
        let seasonNumber = episodes.map{$0.season}.max() ?? 0
        return String(seasonNumber)
    }
    var numberOfEpisodes: String {
        let numberOfEpisodesFormatted = String(episodes.count)
        return numberOfEpisodesFormatted
    }
    var platformFormatted: String {
        return DefaultString.platform
    }
    var trackedFormatted: Bool {
        return false
    }
}

extension EpisodeInfo: EpisodeFormatted {
    // Formatting properties to conform to EpisodeFormatted:
    
    var episodeNameFormatted: String {
        guard name != "" else {
            return DefaultString.name
        }
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
    var episodeIdFormatted: Int {
        let stringID = "\(season)\(episode)"
        guard let id = Int(stringID) else {
            return 0
        }
        return id
    }
}
