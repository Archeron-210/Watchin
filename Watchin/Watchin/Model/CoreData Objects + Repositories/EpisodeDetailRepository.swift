//
//  EpisodeDetailRepository.swift
//  Watchin
//
//  Created by Archeron on 25/02/2022.
//

import Foundation
import CoreData

class EpisodeDetailRepository {

    // MARK: - Properties

    static let shared = EpisodeDetailRepository()
    private let coreDataStack: CoreDataStackProtocol

    // MARK: - Init

    init(coreDataStack: CoreDataStackProtocol = CoreDataStack.shared) {
        self.coreDataStack = coreDataStack
    }

    // MARK: - Data Management

    func saveEpisodeDetail(for episode: EpisodeFormatted, show: ShowDetailFormatted) {
        let episodeDetail = EpisodeDetail(context: coreDataStack.viewContext)
        episodeDetail.episodeNumber = Int32(episode.episodeNumberFormatted)
        episodeDetail.seasonNumber = Int32(episode.seasonNumberFormatted)
        episodeDetail.name = episode.episodeNameFormatted
        episodeDetail.hasBeenWatched = episode.hasBeenWatchedFormatted
        episodeDetail.watchinShow = show as? WatchinShow

        do {
            try coreDataStack.viewContext.save()
        } catch {
            print("Unable to save desired object")
        }
    }
}
