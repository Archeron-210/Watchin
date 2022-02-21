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

    func getWatchinShows() -> [WatchinShow] {
        let request: NSFetchRequest<WatchinShow> = WatchinShow.fetchRequest()
        do {
            let watchinShows = try coreDataStack.viewContext.fetch(request)
            return watchinShows
        } catch {
            print("We were unable to retrieve shows")
            return []
        }
    }

    func saveWatchinShow(show: TvShowInfo) {

    }

    func deleteWatchinShow() {

    }
}
