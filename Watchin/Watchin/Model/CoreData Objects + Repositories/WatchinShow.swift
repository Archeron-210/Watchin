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
        return name ?? DefaultString.name
    }
    var descriptionFormatted: String {
        return descriptionText ?? DefaultString.description
    }
    var descriptionSourceFormatted: String {
        return descriptionSource ?? DefaultString.descriptionSource
    }
    var startDateFormatted: String {
        return startDate ?? DefaultString.date
    }
    var countryFormatted: String {
        return country ?? DefaultString.country
    }
    var statusFormatted: String {
        return status ?? DefaultString.status
    }
    var imageStringUrlFormatted: String {
        return imageStringUrl ?? DefaultString.stringUrl
    }
    var genresFormatted: String {
        return genres ?? DefaultString.genre
    }
    var numberOfSeasons: String {
        return totalSeasons ?? DefaultString.numberOfSeasons
    }
    var numberOfEpisodes: String {
        return totalEpisodes ?? DefaultString.numberOfEpisodes
    }
    var platformFormatted: String {
        return platform ?? DefaultString.platform
    }
    var trackedFormatted: Bool {
        return tracked
    }
}

