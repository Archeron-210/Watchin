//
//  FakeEpisodes.swift
//  WatchinTests
//
//  Created by Archeron on 09/03/2022.
//

import Foundation
@testable import Watchin
import CoreData


class FakeEpisode {

    static func correctEpisode() -> EpisodeFormatted {

       return EpisodeInfo(season: 01, episode: 01, name: "First episode")
    }

    static func incorrectEpisode() -> EpisodeFormatted {

        return EpisodeInfo(season: 0, episode: 0, name: "")
    }
}

class FakeEpisodeDetail {

    static func correctEpisodeDetail(coreDataStack: CoreDataStackProtocol, episodeRepository: EpisodeDetailRepository, showRepository: WatchinShowRepository) -> EpisodeDetail {

        let episode = FakeEpisode.correctEpisode()
        let episodeDetail = EpisodeDetail(context: coreDataStack.viewContext)
        episodeDetail.episodeId = Int32(episode.episodeIdFormatted)
        episodeDetail.name = episode.episodeNameFormatted
        episodeDetail.seasonNumber = Int32(episode.seasonNumberFormatted)
        episodeDetail.episodeNumber = Int32(episode.episodeNumberFormatted)
        episodeDetail.hasBeenWatched = episode.hasBeenWatchedFormatted
        episodeDetail.watchinShow = showRepository.getWatchinShow(id: FakeShow.correctTvShowInfo().idFormatted)

        episodeRepository.saveEpisodeDetail(for: episodeDetail, of: FakeShow.correctTvShowInfo())

        return episodeDetail
    }

    static func incorrectEpisodeDetail(coreDataStack: CoreDataStackProtocol, episodeRepository: EpisodeDetailRepository, showRepository: WatchinShowRepository) -> EpisodeDetail {

        let episode = FakeEpisode.incorrectEpisode()
        let wrongEpisodeDetail = EpisodeDetail(context: coreDataStack.viewContext)
        wrongEpisodeDetail.episodeId = Int32(episode.episodeIdFormatted)
        wrongEpisodeDetail.name = episode.episodeNameFormatted
        wrongEpisodeDetail.seasonNumber = Int32(episode.seasonNumberFormatted)
        wrongEpisodeDetail.episodeNumber = Int32(episode.episodeNumberFormatted)
        wrongEpisodeDetail.hasBeenWatched = episode.hasBeenWatchedFormatted
        wrongEpisodeDetail.watchinShow = showRepository.getWatchinShow(id: FakeShow.correctTvShowInfo().idFormatted)

        episodeRepository.saveEpisodeDetail(for: wrongEpisodeDetail, of: FakeShow.correctTvShowInfo())

        return wrongEpisodeDetail
    }

}
