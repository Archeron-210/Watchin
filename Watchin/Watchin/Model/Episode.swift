//
//  Episode.swift
//  Watchin
//
//  Created by Archeron on 28/02/2022.
//

import Foundation

struct Episode: EpisodeFormatted {
    // an Episode is an object that ONLY implements EpisodeFormatted: it allows to manipulate an object throughout the app that is purely an EpisodeFormatted, without being an object that conforms to it, so at this state there are no computed properties

    var episodeNameFormatted: String
    var episodeNumberFormatted: Int
    var seasonNumberFormatted: Int
    var hasBeenWatchedFormatted: Bool

    // MARK: - Init
    // allows to create a Show with any object that conforms to EpisodeFormatted

    init(episodeFormatted: EpisodeFormatted) {
        self.episodeNameFormatted = episodeFormatted.episodeNameFormatted
        self.episodeNumberFormatted = episodeFormatted.episodeNumberFormatted
        self.seasonNumberFormatted = episodeFormatted.seasonNumberFormatted
        self.hasBeenWatchedFormatted = episodeFormatted.hasBeenWatchedFormatted
    }
}
