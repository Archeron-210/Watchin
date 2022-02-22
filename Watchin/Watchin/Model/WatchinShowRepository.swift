//
//  WatchinShowRepository.swift
//  Watchin
//
//  Created by Archeron on 21/02/2022.
//

import Foundation
import CoreData

class WatchinShowRepository {

    // MARK: - Properties

    private let coreDataStack: CoreDataStackProtocol

    // MARK: - Init

    init(coreDataStack: CoreDataStackProtocol = CoreDataStack.shared) {
        self.coreDataStack = coreDataStack
    }

    func getShows() -> [ShowDetailFormatted] {
        // creates a copy to use elsewhere in the app, without using specifically an object that has a CoreData reference by transforming a WatchinShow in a ShowDetailFormatted object :
        return getWatchinShows().map { Show(showDetailFormatted: $0) }
    }

    func saveWatchinShow(show: ShowDetailFormatted) {
        // check si deja enregistré

        let watchinShow = WatchinShow(context: coreDataStack.viewContext)
        watchinShow.id = Int32(show.idFormatted)
        watchinShow.name = show.nameFormatted
        watchinShow.descriptionText = show.descriptionFormatted
        watchinShow.descriptionSource = show.descriptionSourceFormatted
        watchinShow.startDate = show.startDateFormatted
        watchinShow.country = show.countryFormatted
        watchinShow.status = show.statusFormatted
        watchinShow.imageStringUrl = show.imageStringUrlFormatted
        watchinShow.genres = show.genresFormatted
        watchinShow.totalSeasons = show.numberOfSeasons
        watchinShow.totalEpisodes = show.numberOfEpisodes
        watchinShow.watchedSeasons = Int32(show.watchedSeasonsFormatted)
        watchinShow.watchedEpisodes = Int32(show.watchedEpisodesFormatted)
        watchinShow.platform = show.platformFormatted

        do {
            try coreDataStack.viewContext.save()
        } catch {
            print("We were unable to save this show")
        }

    }

    func deleteWatchinShow() {
        // à faire
    }

    // MARK: - Private

    private func getWatchinShows() -> [WatchinShow] {
        let request: NSFetchRequest<WatchinShow> = WatchinShow.fetchRequest()
        do {
            let watchinShows = try coreDataStack.viewContext.fetch(request)
            return watchinShows
        } catch {
            print("We were unable to retrieve shows")
            return []
        }
    }
}
