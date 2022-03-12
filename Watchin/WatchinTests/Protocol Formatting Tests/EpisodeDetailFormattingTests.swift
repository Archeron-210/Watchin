//
//  EpisodeDetailFormattingTests.swift
//  WatchinTests
//
//  Created by Archeron on 09/03/2022.
//

import XCTest
@testable import Watchin

class EpisodeDetailFormattingTest: XCTestCase {

    // MARK: - Properties

    private var correctTestEpisodeDetail: EpisodeFormatted!
    private var incorrectTestEpisodeDetail: EpisodeFormatted!

    // MARK: - setUp & tearDown

    override func setUp() {
        super.setUp()
        let coreDataStack = CoreDataTestStack()
        let watchinShowRepository = WatchinShowRepository(coreDataStack: coreDataStack)
        let episodeRepository = EpisodeDetailRepository(coreDataStack: coreDataStack, watchinShowRepository: watchinShowRepository)
        correctTestEpisodeDetail = FakeEpisodeDetail.correctEpisodeDetail(coreDataStack: coreDataStack, episodeRepository: episodeRepository, showRepository: watchinShowRepository)
        incorrectTestEpisodeDetail = FakeEpisodeDetail.incorrectEpisodeDetail(coreDataStack: coreDataStack, episodeRepository: episodeRepository, showRepository: watchinShowRepository)
    }

    override func tearDown() {
        super.tearDown()
        correctTestEpisodeDetail = nil
        incorrectTestEpisodeDetail = nil
    }

    // MARK: - correctEpisodeDetail tests

    func testGivenEpisodeDetailHasNoId_WhenConformingToProtocol_ThenEpisodeDetailHasAnIdFormatted() {
        XCTAssertEqual(correctTestEpisodeDetail.episodeIdFormatted, 11)
    }

    func testGivenEpisodeDetailHasAName_WhenConformingToProtocol_ThenEpisodeDetailHasANameFormatted() {
        XCTAssertEqual(correctTestEpisodeDetail.episodeNameFormatted, "First episode")
    }

    func testGivenEpisodeDetailHasAnEpisodeNumber_WhenConformingToProtocol_ThenEpisodeDetailHasAnEpisodeNumberFormatted() {
        XCTAssertEqual(correctTestEpisodeDetail.episodeNumberFormatted, 01)
    }

    func testGivenEpisodeDetailHasASeasonNumber_WhenConformingToProtocol_ThenEpisodeDetailHasASeasonNumberFormatted() {
        XCTAssertEqual(correctTestEpisodeDetail.seasonNumberFormatted, 01)
    }

    func testGivenEpisodeDetailHasNoHasBeenWatchedProperty_WhenConformingToProtocol_ThenEpisodeDetailHasAHasBeenWatchedFormattedPropertyAndItReturnsFalse() {
        XCTAssertEqual(correctTestEpisodeDetail.hasBeenWatchedFormatted, false)
    }

    // MARK: - incorrectEpisodeDetail Tests

    func testGivenIncorrectEpisodeDetailHasNoId_WhenConformingToProtocol_ThenIncorrectEpisodeDetailHasAnIdFormattedOfZero() {
        XCTAssertEqual(incorrectTestEpisodeDetail.episodeIdFormatted, 0)
    }

    func testGivenEpisodeDetailHasNoName_WhenConformingToProtocol_ThenEpisodeDetailHasANameFormatted() {
        XCTAssertEqual(incorrectTestEpisodeDetail.episodeNameFormatted, DefaultString.name)
    }

    func testGivenEpisodeDetailHasAnEpisodeNumberOfZero_WhenConformingToProtocol_ThenEpisodeDetailHasAnEpisodeNumberFormattedOfZero() {
        XCTAssertEqual(incorrectTestEpisodeDetail.episodeNumberFormatted, 0)
    }

    func testGivenEpisodeDetailHasASeasonNumberOfZero_WhenConformingToProtocol_ThenEpisodeDetailHasASeasonNumberFormattedOfZero() {
        XCTAssertEqual(incorrectTestEpisodeDetail.seasonNumberFormatted, 0)
    }

    func testGivenIncorrectEpisodeDetailHasNoHasBeenWatchedProperty_WhenConformingToProtocol_ThenIncorrectEpisodeDetailHasAHasBeenWatchedFormattedPropertyAndItReturnsFalse() {
        XCTAssertEqual(incorrectTestEpisodeDetail.hasBeenWatchedFormatted, false)
    }

}
