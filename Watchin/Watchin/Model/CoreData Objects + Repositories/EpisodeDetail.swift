//
//  EpisodeDetail.swift
//  Watchin
//
//  Created by Archeron on 25/02/2022.
//

import Foundation
import CoreData

class EpisodeDetail: NSManagedObject {}

extension EpisodeDetail: EpisodeFormatted {

    var episodeNameFormatted: String {
        return name ?? DefaultString.name
    }
    var episodeNumberFormatted: Int {
        let intEpisodeNumber = Int(episodeNumber)
        return intEpisodeNumber
    }
    var seasonNumberFormatted: Int {
        let intSeasonNumber = Int(seasonNumber)
        return intSeasonNumber
    }
    var hasBeenWatchedFormatted: Bool {
        return hasBeenWatched
    }
    var episodeIdFormatted: Int {
        let intEpisodeId = Int(episodeId)
        return intEpisodeId
    }
}
