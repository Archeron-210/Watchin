//
//  TvShowInfoFormattedTests.swift
//  WatchinTests
//
//  Created by Archeron on 09/03/2022.
//

import XCTest
@testable import Watchin

class TvShowInfoFormattedTests: XCTestCase {

    // MARK: - Properties

    var correctTestShow: ShowDetailFormatted!
    var specialCorrectTestShow: ShowDetailFormatted!
    var incorrectTestShow: ShowDetailFormatted!

    // MARK: - setUp & tearDown

    override func setUp() {
        super.setUp()
        correctTestShow = FakeShow.correctTvShowInfo()
        specialCorrectTestShow = FakeShow.specialCorrectTvShowInfo()
        incorrectTestShow = FakeShow.incorrectTvShowInfo()
    }

    override func tearDown() {
        super.tearDown()
        correctTestShow = nil
        specialCorrectTestShow = nil
        incorrectTestShow = nil
    }

    // MARK: - correctShow Tests

    func testGivenShowHasAnId_WhenConformingToProtocol_ThenShowHasAnIdFormatted() {
        XCTAssertEqual(correctTestShow.idFormatted, 27650)
    }

    func testGivenShowHasAName_WhenConformingToProtocol_ThenShowHasANameFormatted() {
        XCTAssertEqual(correctTestShow.nameFormatted, "Fake Correct Show")
    }

    func testGivenShowHasACountry_WhenConformingToProtocol_ThenShowHasACountryFormatted() {
        XCTAssertEqual(correctTestShow.countryFormatted, "Country: FR")
    }

    func testGivenShowHasADescription_WhenConformingToProtocol_ThenShowHasADescriptionFormatted() {
        XCTAssertEqual(correctTestShow.descriptionFormatted, "A fake correct show for tests")
    }

    func testGivenShowHasADescriptionSource_WhenConformingToProtocol_ThenShowHasADescriptionSourceFormatted() {
        XCTAssertEqual(correctTestShow.descriptionSourceFormatted, "https://www.google.com")
    }

    func testGivenShowHasAStartDate_WhenConformingToProtocol_ThenShowHasAStartDateFormatted() {
        XCTAssertEqual(correctTestShow.startDateFormatted, "(2022)")
    }

    func testGivenShowHasAStatus_WhenConformingToProtocol_ThenShowHasAStatusFormatted() {
        XCTAssertEqual(correctTestShow.statusFormatted, "Running")
    }

    func testGivenShowHasAnImageStringUrl_WhenConformingToProtocol_ThenShowHasAnImageStringUrlFormatted() {
        XCTAssertEqual(correctTestShow.imageStringUrlFormatted, "https://static.episodate.com/images/tv-show/thumbnail/29560.jpg")
    }

    func testGivenShowHasGenres_WhenConformingToProtocol_ThenShowHasItsGenresFormatted() {
        XCTAssertEqual(correctTestShow.genresFormatted, "Action, Science, Drama")
    }

    func testGivenShowHasSeasons_WhenConformingToProtocol_ThenShowHasANumberOfSeasonsFormatted() {
        XCTAssertEqual(correctTestShow.numberOfSeasons, "2")

    }

    func testGivenShowHasEpisodes_WhenConformingToProtocol_ThenShowHasANumberOfEpisodesFormatted() {
        XCTAssertEqual(correctTestShow.numberOfEpisodes, "4")
    }

    func testGivenShowHasNoPlatform_WhenConformingToProtocol_ThenShowHasAPlatformFormatted() {
        XCTAssertEqual(correctTestShow.platformFormatted, "add platform")
    }

    func testGivenShowHasNoTrackedProperty_WhenConformingToProtocol_ThenShowHasATrackedFormattedPropertyAndItReturnsFalse() {
        XCTAssertEqual(correctTestShow.trackedFormatted, false)
    }

    // MARK: - SpecialCorrectShow tests

    func testGivenShowHasADescriptionWithSpecialCharacters_WhenConformingToProtocol_ThenShowHasADescriptionFormatted() {
        XCTAssertEqual(specialCorrectTestShow.descriptionFormatted, "A fake correct show for tests")
    }

    func testGivenShowHasAnEmptyDescriptionSource_WhenConformingToProtocol_ThenShowHasADescriptionSourceFormattedThatWillSendUserToAGoogleSearch() {
        XCTAssertEqual(specialCorrectTestShow.descriptionSourceFormatted, "https://www.google.com/search?q=Fake+Correct+Show")
    }

    func testGivenShowHasAStartDateWithLetters_WhenConformingToProtocol_ThenShowHasAStartDateFormatted() {
        XCTAssertEqual(specialCorrectTestShow.startDateFormatted, "(1958)")
    }
}
