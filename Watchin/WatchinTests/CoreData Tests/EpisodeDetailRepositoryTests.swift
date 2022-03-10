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

    
}
