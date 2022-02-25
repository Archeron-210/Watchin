//
//  WatchinShow.swift
//  Watchin
//
//  Created by Archeron on 20/02/2022.
//

import Foundation
import CoreData

class WatchinShow: NSManagedObject {}

// MARK: - Protocol Implementation

extension WatchinShow: ShowDetailFormatted {

    var idFormatted: Int {
        let intId = Int(id)
        return intId
    }

    var nameFormatted: String {
        return name ?? "No name"
    }

    var descriptionFormatted: String {
        return descriptionText ?? "No description"
    }

    var descriptionSourceFormatted: String {
        return descriptionSource ?? "No description source"
    }

    var startDateFormatted: String {
        return startDate ?? "No start date"
    }

    var countryFormatted: String {
        return country ?? "No country"
    }

    var statusFormatted: String {
        return status ?? "No status"
    }

    var imageStringUrlFormatted: String {
        return imageStringUrl ?? "No imageStringUrl"
    }

    var genresFormatted: String {
        return genres ?? "No genres"
    }

    var numberOfSeasons: String {
        return totalSeasons ?? "No number of seasons"
    }

    var numberOfEpisodes: String {
        return totalEpisodes ?? "No number of episodes"
    }

    var watchedSeasonsFormatted: Int {
        let intWatchedSeasons = Int(watchedSeasons)
        return intWatchedSeasons
    }

    var watchedEpisodesFormatted: Int {
        let intWatchedEpisodes = Int(watchedEpisodes)
        return intWatchedEpisodes
    }

    var platformFormatted: String {
        return platform ?? "No platform"
    }
}
