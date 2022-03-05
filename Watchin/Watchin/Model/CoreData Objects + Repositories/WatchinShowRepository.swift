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

    static let shared = WatchinShowRepository()
    private let coreDataStack: CoreDataStackProtocol

    // MARK: - Init

    init(coreDataStack: CoreDataStackProtocol = CoreDataStack.shared) {
        self.coreDataStack = coreDataStack
    }

    // MARK: - Data Management

    func getShows() -> [ShowDetailFormatted] {
        // creates a copy to use elsewhere in the app, without using specifically an object that has a CoreData reference by transforming a WatchinShow in a ShowDetailFormatted object :
        return getWatchinShows().map { Show(showDetailFormatted: $0) }
    }

    func getWatchinShow(id: Int) -> WatchinShow? {
        return getWatchinShows().first {
            $0.idFormatted == id
        }
    }

    func saveWatchinShow(show: ShowDetailFormatted) -> Bool {
        guard !isAlreadySaved(show: show) else {
            return false
        }
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
        watchinShow.platform = show.platformFormatted

        do {
            try coreDataStack.viewContext.save()
            return true
        } catch {
            print("Unable to save this show")
            return false
        }
    }

    func updateWatchinShowPlatform(show: ShowDetailFormatted, platform: String) {
        let searchedShow = getWatchinShows().first(where: { (watchinShow) -> Bool in
            return watchinShow.idFormatted == show.idFormatted
        })
        guard let foundWatchinShow = searchedShow else {
            print("WatchinShow not found, unable to save desired changes")
            return
        }
        do {
            foundWatchinShow.platform = platform
            try coreDataStack.viewContext.save()
        } catch {
            print("Unable to save desired changes")
        }
    }

    func deleteWatchinShow(show: ShowDetailFormatted) {
        let searchedShow = getWatchinShows().first(where: { (watchinShow) -> Bool in
            return watchinShow.id == show.idFormatted
        })
        guard let foundWatchinShow = searchedShow else {
            return
        }
        coreDataStack.viewContext.delete(foundWatchinShow)
        do {
            try coreDataStack.viewContext.save()
        } catch {
            print("Unable to delete this show")
        }
    }

    func isAlreadySaved(show: ShowDetailFormatted) -> Bool {
        let searchedShow = getWatchinShows().first { (watchinShow) -> Bool in
            return watchinShow.idFormatted == show.idFormatted
        }
        return searchedShow != nil
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
