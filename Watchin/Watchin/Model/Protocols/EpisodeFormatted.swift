//
//  EpisodeFormatted.swift
//  Watchin
//
//  Created by Archeron on 25/02/2022.
//

import Foundation

protocol EpisodeFormatted {
    var episodeNameFormatted: String { get }
    var episodeNumberFormatted: Int { get }
    var seasonNumberFormatted: Int { get }
    var episodeIdFormatted: Int { get }
    var hasBeenWatchedFormatted: Bool { get }
}
