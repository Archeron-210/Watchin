//
//  EpisodeDetailRepositoryTests.swift
//  WatchinTests
//
//  Created by Archeron on 09/03/2022.
//

import XCTest
@testable import Watchin

class EpisodeDetailRepositoryTests: XCTestCase {

    // MARK: - Properties

    var coreDataStack: CoreDataStackProtocol!
    var episodeRepository: EpisodeDetailRepository!
    var watchinShowRepository: WatchinShowRepository!
    var validShow: ShowDetailFormatted!

    // MARK: - setUp & tearDown

    override func setUp() {
        super.setUp()
        coreDataStack = CoreDataTestStack()
        watchinShowRepository = WatchinShowRepository(coreDataStack: coreDataStack)
        episodeRepository = EpisodeDetailRepository(coreDataStack: coreDataStack, watchinShowRepository: watchinShowRepository)
        validShow = FakeShow.correctTvShowInfo()
        _ = watchinShowRepository.saveWatchinShow(show: validShow)
    }

    override func tearDown() {
        coreDataStack = nil
        episodeRepository = nil
        watchinShowRepository = nil
        validShow = nil
    }

    // MARK: - Tests

    func testGivenAnEpisodeIsValid_WhenSavingIt_ThenEpisodeIsCorrectlySaved() {
        let validEpisode = FakeEpisode.correctEpisode()

        episodeRepository.saveEpisodeDetail(for: validEpisode, of: validShow)

        let episode = episodeRepository.getEpisode(for: validEpisode.episodeIdFormatted, in: validShow)

        XCTAssertEqual(episode?.episodeIdFormatted, validEpisode.episodeIdFormatted)
        XCTAssertEqual(episode?.episodeNameFormatted, validEpisode.episodeNameFormatted)
        XCTAssertEqual(episode?.episodeNumberFormatted, validEpisode.episodeNumberFormatted)
        XCTAssertEqual(episode?.seasonNumberFormatted, validEpisode.seasonNumberFormatted)
        XCTAssertEqual(episode?.hasBeenWatchedFormatted, validEpisode.hasBeenWatchedFormatted)
    }

    func testGivenAnEpisodeIsValid_WhenSavingItToNonExistingShow_ThenEpisodeIsNotSaved() {
        let incorrectShow = FakeShow.incorrectTvShowInfo()
        let validEpisode = FakeEpisode.correctEpisode()

        episodeRepository.saveEpisodeDetail(for: validEpisode, of: incorrectShow)

        let episode = episodeRepository.getEpisode(for: validEpisode.episodeIdFormatted, in: incorrectShow)

        XCTAssertNil(episode)
    }

    func testGivenAShowHasMultipleEpisodesAndSeasons_WhenSavingItsEpisodes_ThenItsPossibleToRetrieveAnArrayOfArrayOfEpisodesBySeasons() {
        let episode1 = FakeEpisode.correctEpisode()
        let episode2 = FakeEpisode.correctEpisode2()
        let episode3 = FakeEpisode.correctEpisode3()
        let episode4 = FakeEpisode.correctEpisode4()

        episodeRepository.saveEpisodeDetail(for: episode1, of: validShow)
        episodeRepository.saveEpisodeDetail(for: episode2, of: validShow)
        episodeRepository.saveEpisodeDetail(for: episode3, of: validShow)
        episodeRepository.saveEpisodeDetail(for: episode4, of: validShow)

        let episodesBySeasons = episodeRepository.getEpisodes(for: validShow)
        let totalEpisodes = episodesBySeasons.flatMap({ $0 })
        XCTAssertEqual(episodesBySeasons.count, 2)
        XCTAssertEqual(totalEpisodes.count, 4)
    }

    func testGivenAnEpisodeHasNotBeenWatched_WhenUpdatingItsWatchedStatus_ThenThisEpisodeHasBeenWatched() {

        let episode = FakeEpisode.correctEpisode()
        episodeRepository.saveEpisodeDetail(for: episode, of: validShow)
        XCTAssertEqual(episode.hasBeenWatchedFormatted, false)

        episodeRepository.updateEpisodeWatchedStatus(episode: episode, of: validShow)

        let updatedEpisodewatchedStatus = episodeRepository.getEpisode(for: episode.episodeIdFormatted, in: validShow)
        XCTAssertEqual(updatedEpisodewatchedStatus?.hasBeenWatchedFormatted, true)
    }

    func testGivenAShowHasMultipleEpisodes_WhenUpdatingSomeEpisodesWatchedStatus_ThenItIsPossibleToRetrieveTheWatchedEpisodes() {
        let episode1 = FakeEpisode.correctEpisode()
        let episode2 = FakeEpisode.correctEpisode2()
        let episode3 = FakeEpisode.correctEpisode3()
        let episode4 = FakeEpisode.correctEpisode4()
        episodeRepository.saveEpisodeDetail(for: episode1, of: validShow)
        episodeRepository.saveEpisodeDetail(for: episode2, of: validShow)
        episodeRepository.saveEpisodeDetail(for: episode3, of: validShow)
        episodeRepository.saveEpisodeDetail(for: episode4, of: validShow)

        episodeRepository.updateEpisodeWatchedStatus(episode: episode1, of: validShow)
        episodeRepository.updateEpisodeWatchedStatus(episode: episode2, of: validShow)

        let watchedEpisodes = episodeRepository.getWatchedEpisodes(for: validShow)
        XCTAssertEqual(watchedEpisodes.count, 2)

    }

    func testGivenAShowHasSomeEpisodesWatched_WhenDeletingItsWatchedEpisodes_ThenShowHasNotAnyWatchedEpisodesAnymore() {
        let episode1 = FakeEpisode.correctEpisode()
        let episode2 = FakeEpisode.correctEpisode2()
        episodeRepository.saveEpisodeDetail(for: episode1, of: validShow)
        episodeRepository.saveEpisodeDetail(for: episode2, of: validShow)
        episodeRepository.updateEpisodeWatchedStatus(episode: episode1, of: validShow)
        episodeRepository.updateEpisodeWatchedStatus(episode: episode2, of: validShow)
        let watchedEpisodes = episodeRepository.getWatchedEpisodes(for: validShow)
        XCTAssertEqual(watchedEpisodes.count, 2)

        episodeRepository.deleteWatchedEpisodes(for: validShow)

        let updatedWatchedEpisodes = episodeRepository.getWatchedEpisodes(for: validShow)

        XCTAssertTrue(updatedWatchedEpisodes.isEmpty)
    }
    
}
