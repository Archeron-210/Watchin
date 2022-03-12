//
//  TvShowInfoFormattingTests.swift
//  WatchinTests
//
//  Created by Archeron on 09/03/2022.
//

import XCTest
@testable import Watchin

class TvShowInfoFormattingTests: XCTestCase {

    // MARK: - Properties

    private var correctTestShow: ShowDetailFormatted!
    private var specialCorrectTestShow: ShowDetailFormatted!
    private var incorrectTestShow: ShowDetailFormatted!

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
        XCTAssertEqual(correctTestShow.platformFormatted, DefaultString.platform)
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

    // MARK: - incorrectShow tests

    func testGivenShowHasZeroAsId_WhenConformingToProtocol_ThenShowHasAnIdFormatted() {
        XCTAssertEqual(incorrectTestShow.idFormatted, 0)
    }

    func testGivenShowHasAnEmptyName_WhenConformingToProtocol_ThenShowHasANameFormatted() {
        XCTAssertEqual(incorrectTestShow.nameFormatted, DefaultString.name)
    }

    func testGivenShowHasAnEmptyDescription_WhenConformingToProtocol_ThenShowHasADescriptionFormatted() {
        XCTAssertEqual(incorrectTestShow.descriptionFormatted, DefaultString.description)
    }

    func testGivenShowHasAnEmptyDescriptionSource_WhenConformingToProtocol_ThenShowHasADescriptionSourceFormatted() {
        XCTAssertEqual(incorrectTestShow.descriptionSourceFormatted, DefaultString.descriptionSource)
    }

    func testGivenShowHasNoStartDate_WhenConformingToProtocol_ThenShowHasAStartDateFormatted() {
        XCTAssertEqual(incorrectTestShow.startDateFormatted, DefaultString.date)
    }

    func testGivenShowHasNoCountry_WhenConformingToProtocol_ThenShowHasACountryFormatted() {
        XCTAssertEqual(incorrectTestShow.countryFormatted, DefaultString.country)
    }

    func testGivenShowHasNoStatus_WhenConformingToProtocol_ThenShowHasAStatusFormatted() {
        XCTAssertEqual(incorrectTestShow.statusFormatted, DefaultString.status)
    }

    func testGivenShowHasNoImageStringUrl_WhenConformingToProtocol_ThenShowHasAImageStringUrlFormatted() {
        XCTAssertEqual(incorrectTestShow.imageStringUrlFormatted, DefaultString.stringUrl)
    }

    func testGivenShowHasNoGenres_WhenConformingToProtocol_ThenShowHasAGenresFormatted() {
        XCTAssertEqual(incorrectTestShow.genresFormatted, DefaultString.genre)
    }

    func testGivenShowHasNoEpisodes_WhenConformingToProtocol_ThenItsNumberOfEpisodesAndNumberOfSeasonsAreFormattedAndAreZero() {
        XCTAssertEqual(incorrectTestShow.numberOfEpisodes, "0")
        XCTAssertEqual(incorrectTestShow.numberOfSeasons, "0")
    }

    func testGivenIncorrectShowHasNoTrackedProperty_WhenConformingToProtocol_ThenIncorrectShowHasATrackedFormattedPropertyAndItReturnsFalse() {
        XCTAssertEqual(incorrectTestShow.trackedFormatted, false)
    }

    func testGivenIncorrectShowHasNoPlatform_WhenConformingToProtocol_ThenIncorrectShowHasAPlatformFormatted() {
        XCTAssertEqual(incorrectTestShow.platformFormatted, DefaultString.platform)
    }


}


