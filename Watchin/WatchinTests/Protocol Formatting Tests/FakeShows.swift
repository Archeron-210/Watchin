//
//  FakeShows.swift
//  WatchinTests
//
//  Created by Archeron on 09/03/2022.
//

import Foundation
@testable import Watchin
import CoreData

class FakeShow {

    static func correctTvShowInfo() -> ShowDetailFormatted {
        return TvShowInfo(id: 27650,
                          name: "Fake Correct Show",
                          description: "A fake correct show for tests",
                          descriptionSource: "https://www.google.com",
                          startDate: "2022-03-09",
                          country: "FR",
                          status: "Running",
                          imageStringUrl: "https://static.episodate.com/images/tv-show/thumbnail/29560.jpg",
                          genres: ["Action","Science","Drama"],
                          episodes: [EpisodeInfo(season: 01, episode: 01, name: "Start01"), EpisodeInfo(season: 01, episode: 02, name: "End01"), EpisodeInfo(season: 02, episode: 01, name: "Start02"), EpisodeInfo(season: 02, episode: 02, name: "End02") ])
    }

    static func specialCorrectTvShowInfo() -> ShowDetailFormatted {
        // a show with special format in description, startDate and no descriptionSource
        return TvShowInfo(id: 27651,
                          name: "Fake Correct Show",
                          description: "A fake <b>correct</b> show for tests",
                          descriptionSource: nil,
                          startDate: "Jan/19/1958",
                          country: "FR",
                          status: "Running",
                          imageStringUrl: "https://static.episodate.com/images/tv-show/thumbnail/29560.jpg",
                          genres: ["Action","Science","Drama"],
                          episodes: [EpisodeInfo(season: 01, episode: 01, name: "Start01"), EpisodeInfo(season: 01, episode: 02, name: "End01"), EpisodeInfo(season: 02, episode: 01, name: "Start02"), EpisodeInfo(season: 02, episode: 02, name: "End02") ])
    }

    static func incorrectTvShowInfo() -> ShowDetailFormatted {
        return TvShowInfo(id: 0,
                          name: "",
                          description: "",
                          descriptionSource: "",
                          startDate: "",
                          country: "",
                          status: "",
                          imageStringUrl: "",
                          genres: [],
                          episodes: [])
    }
}

class FakeWatchinShow {

    static func correctFakeWatchinShow(coreDataStack: CoreDataStackProtocol, repository: WatchinShowRepository) -> WatchinShow {

        let show = FakeShow.correctTvShowInfo()
        let watchinShow = WatchinShow(context: coreDataStack.viewContext)
        watchinShow.id = Int32(show.idFormatted)
        watchinShow.name = show.nameFormatted
        watchinShow.country = show.countryFormatted
        watchinShow.descriptionText = show.descriptionFormatted
        watchinShow.descriptionSource = show.descriptionSourceFormatted
        watchinShow.startDate = show.startDateFormatted
        watchinShow.status = show.statusFormatted
        watchinShow.imageStringUrl = show.imageStringUrlFormatted
        watchinShow.genres = show.genresFormatted
        watchinShow.totalSeasons = show.numberOfSeasons
        watchinShow.totalEpisodes = show.numberOfEpisodes
        watchinShow.platform = show.platformFormatted
        watchinShow.tracked = show.trackedFormatted

        let success = repository.saveWatchinShow(show: watchinShow)
        print("\(success)")
        return watchinShow
    }

    static func incorrectFakeWatchinShow(coreDataStack: CoreDataStackProtocol, repository: WatchinShowRepository) -> WatchinShow {

        let show = FakeShow.incorrectTvShowInfo()
        let wrongWatchinShow = WatchinShow(context: coreDataStack.viewContext)
        wrongWatchinShow.id = Int32(show.idFormatted)
        wrongWatchinShow.name = show.nameFormatted
        wrongWatchinShow.country = show.countryFormatted
        wrongWatchinShow.descriptionText = show.descriptionFormatted
        wrongWatchinShow.descriptionSource = show.descriptionSourceFormatted
        wrongWatchinShow.startDate = show.startDateFormatted
        wrongWatchinShow.status = show.statusFormatted
        wrongWatchinShow.imageStringUrl = show.imageStringUrlFormatted
        wrongWatchinShow.genres = show.genresFormatted
        wrongWatchinShow.totalSeasons = show.numberOfSeasons
        wrongWatchinShow.totalEpisodes = show.numberOfEpisodes
        wrongWatchinShow.platform = show.platformFormatted
        wrongWatchinShow.tracked = show.trackedFormatted

        let wrongSuccess = repository.saveWatchinShow(show: wrongWatchinShow)
        print("\(wrongSuccess)")
        return wrongWatchinShow
    }

}
