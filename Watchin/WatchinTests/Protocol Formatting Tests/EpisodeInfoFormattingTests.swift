//
//  EpisodeInfoFormattingTests.swift
//  WatchinTests
//
//  Created by Archeron on 09/03/2022.
//

import XCTest
@testable import Watchin

class EpisodeInfoFormattingTests: XCTestCase {

    // MARK: - Properties

    var correctTestEpisode: EpisodeFormatted!

    // MARK: - setUp & tearDown

    override func setUp() {
        super.setUp()
        correctTestEpisode = FakeEpisode.correctEpisode()
    }

    override func tearDown() {
        super.tearDown()
        correctTestEpisode = nil
    }

    // MARK: - correctEpisode Tests

    func testGivenEpisodeHasNoId_WhenConformingToProtocol_ThenEpisodeHasAnIdFormatted() {
        XCTAssertEqual(correctTestEpisode.episodeIdFormatted, 11)
    }

    func testGivenEpisodeHasAName_WhenConformingToProtocol_ThenEpisodeHasANameFormatted() {
        XCTAssertEqual(correctTestEpisode.episodeNameFormatted, "First Episode")
    }

    func testGivenEpisodeHasAnEpisodeNumber_WhenConformingToProtocol_ThenEpisodeHasAnEpisodeNumberFormatted() {
        XCTAssertEqual(correctTestEpisode.episodeNumberFormatted, 01)
    }

    func testGivenEpisodeHasASeasonNumber_WhenConformingToProtocol_ThenEpisodeHasASeasonNumberFormatted() {
        XCTAssertEqual(correctTestEpisode.seasonNumberFormatted, 01)
    }

    func testGivenEpisodeHasNoHasBeenWatchedProperty_WhenConformingToProtocol_ThenEpisodeHasAHasBeenWatchedFormattedPropertyAndItReturnsFalse() {
        XCTAssertEqual(correctTestEpisode.hasBeenWatchedFormatted, false)
    }
}
