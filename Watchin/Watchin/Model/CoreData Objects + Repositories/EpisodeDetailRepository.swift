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
    private let watchinShowRepository: WatchinShowRepository

    // MARK: - Init

    init(coreDataStack: CoreDataStackProtocol = CoreDataStack.shared, watchinShowRepository: WatchinShowRepository = WatchinShowRepository.shared) {
        self.coreDataStack = coreDataStack
        self.watchinShowRepository = watchinShowRepository
    }

    // MARK: - Data Management

    func getEpisodes(for show: ShowDetailFormatted) -> [[EpisodeFormatted]] {
        // creates a copy to use elsewhere in the app, without using specifically an object that has a CoreData reference by transforming an EpisodeDetail in an EpisodeFormatted object :
        let episodes = getEpisodeDetails(for: show).map { Episode(episodeFormatted: $0) }
        // creates an array that contains each season number :
        var seasonsNumber: [Int] = []
        episodes.forEach {
            if !seasonsNumber.contains($0.seasonNumberFormatted) {
                seasonsNumber.append($0.seasonNumberFormatted)
            }
        }
        // creates an array of an array for each season, wich contains each episode :
        let episodesBySeason: [[EpisodeFormatted]] = seasonsNumber.map { seasonsNumber in
            episodes.filter { episode in
                seasonsNumber == episode.seasonNumberFormatted
            }
        }
        return episodesBySeason
    }

    func saveEpisodeDetail(for episode: EpisodeFormatted, show: ShowDetailFormatted) {
        let episodeDetail = EpisodeDetail(context: coreDataStack.viewContext)
        episodeDetail.episodeNumber = Int32(episode.episodeNumberFormatted)
        episodeDetail.seasonNumber = Int32(episode.seasonNumberFormatted)
        episodeDetail.name = episode.episodeNameFormatted
        episodeDetail.hasBeenWatched = episode.hasBeenWatchedFormatted
        episodeDetail.watchinShow = watchinShowRepository.getWatchinShow(id: show.idFormatted)

        do {
            try coreDataStack.viewContext.save()
        } catch {
            print("Unable to save desired object")
        }
    }

    // MARK: - Private

    private func getEpisodeDetails(for show: ShowDetailFormatted) -> [EpisodeDetail] {
        let request: NSFetchRequest<EpisodeDetail> = EpisodeDetail.fetchRequest()
        do {
            let episodeDetails = try coreDataStack.viewContext.fetch(request)
            return episodeDetails.filter {
                $0.watchinShow?.idFormatted == show.idFormatted
            }
        } catch {
            return []
        }
    }
}
