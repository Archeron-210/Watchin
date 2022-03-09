//
//  WatchinShowFormattingTests.swift
//  WatchinTests
//
//  Created by Archeron on 09/03/2022.
//

import XCTest
@testable import Watchin

class WatchinShowFormattingTests: XCTestCase {

    // MARK: - Properties

    var correctTestWatchinShow: ShowDetailFormatted!
    var incorrectTestWatchinShow: ShowDetailFormatted!

    // MARK: - setUp & tearDown

    override func setUp() {
        super.setUp()
        let coreDataStack = CoreDataTestStack()
        let repository = WatchinShowRepository(coreDataStack: coreDataStack)
        correctTestWatchinShow = FakeWatchinShow.correctFakeWatchinShow(coreDataStack: coreDataStack, repository: repository)
        incorrectTestWatchinShow = FakeWatchinShow.incorrectFakeWatchinShow(coreDataStack: coreDataStack, repository: repository)
    }

    override func tearDown() {
        super.tearDown()
        correctTestWatchinShow = nil
        incorrectTestWatchinShow = nil
    }

    // MARK: - correctWatchinShow tests

    func testGivenWatchinShowHasAnId_WhenConformingToProtocol_ThenWatchinShowHasAnIdFormatted() {
        XCTAssertEqual(correctTestWatchinShow.idFormatted, 27650)
    }

    func testGivenWatchinShowHasAName_WhenConformingToProtocol_ThenWatchinShowHasANameFormatted() {
        XCTAssertEqual(correctTestWatchinShow.nameFormatted, "Fake Correct Show")
    }

    func testGivenWatchinShowHasACountry_WhenConformingToProtocol_ThenWatchinShowHasACountryFormatted() {
        XCTAssertEqual(correctTestWatchinShow.countryFormatted, "Country: FR")
    }

    func testGivenWatchinShowHasADescription_WhenConformingToProtocol_ThenWatchinShowHasADescriptionFormatted() {
        XCTAssertEqual(correctTestWatchinShow.descriptionFormatted, "A fake correct show for tests")
    }

    func testGivenWatchinShowHasADescriptionSource_WhenConformingToProtocol_ThenWatchinShowHasADescriptionSourceFormatted() {
        XCTAssertEqual(correctTestWatchinShow.descriptionSourceFormatted, "https://www.google.com")
    }

    func testGivenWatchinShowHasAStartDate_WhenConformingToProtocol_ThenWatchinShowHasAStartDateFormatted() {
        XCTAssertEqual(correctTestWatchinShow.startDateFormatted, "(2022)")
    }

    func testGivenWatchinShowHasAStatus_WhenConformingToProtocol_ThenWatchinShowHasAStatusFormatted() {
        XCTAssertEqual(correctTestWatchinShow.statusFormatted, "Running")
    }

    func testGivenWatchinShowHasAnImageStringUrl_WhenConformingToProtocol_ThenWatchinShowHasAnImageStringUrlFormatted() {
        XCTAssertEqual(correctTestWatchinShow.imageStringUrlFormatted, "https://static.episodate.com/images/tv-show/thumbnail/29560.jpg")
    }

    func testGivenWatchinShowHasGenres_WhenConformingToProtocol_ThenWatchinShowHasItsGenresFormatted() {
        XCTAssertEqual(correctTestWatchinShow.genresFormatted, "Action, Science, Drama")
    }

    func testGivenWatchinShowHasEpisodes_WhenConformingToProtocol_ThenWatchinShowHasANumberOfEpisodesFormatted() {
        XCTAssertEqual(correctTestWatchinShow.numberOfEpisodes, "4")
    }

    func testGivenWatchinShowHasSeasons_WhenConformingToProtocol_ThenWatchinShowHasANumberOfSeasonsFormatted() {
        XCTAssertEqual(correctTestWatchinShow.numberOfSeasons, "2")
    }

    func testGivenWatchinShowHasAPlatform_WhenConformingToProtocol_ThenWatchinShowHasAPlatformFormatted() {
        XCTAssertEqual(correctTestWatchinShow.platformFormatted, DefaultString.platform)
    }

    func testGivenWatchinShowHasATrackedPropertyThatReturnsFalse_WhenConformingToProtocol_ThenWatchinShowHasATrackedFormattedPropertyThatReturnsFalse() {
        XCTAssertEqual(correctTestWatchinShow.trackedFormatted, false)
    }

    // MARK: - incorrectWatchinShow tests

    func testGivenWatchinShowHasZeroAsId_WhenConformingToProtocol_ThenWatchinShowHasAnIdFormatted() {
        XCTAssertEqual(incorrectTestWatchinShow.idFormatted, 0)
    }

    func testGivenWatchinShowHasAnEmptyName_WhenConformingToProtocol_ThenWatchinShowHasANameFormatted() {
        XCTAssertEqual(incorrectTestWatchinShow.nameFormatted, DefaultString.name)
    }

    func testGivenWatchinShowHasAnEmptyDescription_WhenConformingToProtocol_ThenWatchinShowHasADescriptionFormatted() {
        XCTAssertEqual(incorrectTestWatchinShow.descriptionFormatted, DefaultString.description)
    }

    func testGivenWatchinShowHasAnEmptyDescriptionSource_WhenConformingToProtocol_ThenWatchinShowHasADescriptionSourceFormatted() {
        XCTAssertEqual(incorrectTestWatchinShow.descriptionSourceFormatted, DefaultString.descriptionSource)
    }

    func testGivenWatchinShowHasNoStartDate_WhenConformingToProtocol_ThenWatchinShowHasAStartDateFormatted() {
        XCTAssertEqual(incorrectTestWatchinShow.startDateFormatted, DefaultString.date)
    }

    func testGivenWatchinShowHasNoCountry_WhenConformingToProtocol_ThenWatchinShowHasACountryFormatted() {
        XCTAssertEqual(incorrectTestWatchinShow.countryFormatted, DefaultString.country)
    }

    func testGivenWatchinShowHasNoStatus_WhenConformingToProtocol_ThenWatchinShowHasAStatusFormatted() {
        XCTAssertEqual(incorrectTestWatchinShow.statusFormatted, DefaultString.status)
    }

    func testGivenWatchinShowHasNoImageStringUrl_WhenConformingToProtocol_ThenWatchinShowHasAImageStringUrlFormatted() {
        XCTAssertEqual(incorrectTestWatchinShow.imageStringUrlFormatted, DefaultString.stringUrl)
    }

    func testGivenWatchinShowHasNoGenres_WhenConformingToProtocol_ThenWatchinShowHasAGenresFormatted() {
        XCTAssertEqual(incorrectTestWatchinShow.genresFormatted, DefaultString.genre)
    }

    func testGivenWatchinShowHasNoEpisodes_WhenConformingToProtocol_ThenItsNumberOfEpisodesAndNumberOfSeasonsAreFormattedAndAreZero() {
        XCTAssertEqual(incorrectTestWatchinShow.numberOfEpisodes, "0")
        XCTAssertEqual(incorrectTestWatchinShow.numberOfSeasons, "0")
    }

    func testGivenIncorrectWatchinShowHasNoTrackedProperty_WhenConformingToProtocol_ThenIncorrectWatchinShowHasATrackedFormattedPropertyAndItReturnsFalse() {
        XCTAssertEqual(incorrectTestWatchinShow.trackedFormatted, false)
    }

    func testGivenIncorrectWatchinShowHasNoPlatform_WhenConformingToProtocol_ThenIncorrectWatchinShowHasAPlatformFormatted() {
        XCTAssertEqual(incorrectTestWatchinShow.platformFormatted, DefaultString.platform)
    }
}
