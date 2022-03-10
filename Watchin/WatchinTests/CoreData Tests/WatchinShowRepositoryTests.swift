//
//  WatchinShowRepositoryTests.swift
//  WatchinTests
//
//  Created by Archeron on 09/03/2022.
//

import XCTest
@testable import Watchin

class WatchinShowRepositoryTests: XCTestCase {

    // MARK: - Properties

    var coreDataStack: CoreDataStackProtocol!
    var watchinShowRepository: WatchinShowRepository!

    //MARK: - setUp & tearDown

    override func setUp() {
        super.setUp()
        coreDataStack = CoreDataTestStack()
        watchinShowRepository = WatchinShowRepository(coreDataStack: coreDataStack)
    }

    override func tearDown() {
        super.tearDown()
        coreDataStack = nil
        watchinShowRepository = nil
    }

    func testGivenAShowIsValid_WhenSavingInWatchinShow_ThenShowIsCorrectlySaved() {

        let validShow = FakeShow.correctTvShowInfo()

        let success = watchinShowRepository.saveWatchinShow(show: validShow)

        let shows = watchinShowRepository.getUntrackedShows()
        XCTAssertTrue(success)
        XCTAssertTrue(!shows.isEmpty)
        XCTAssertEqual(shows.count, 1)
        XCTAssertEqual(shows.first?.idFormatted, validShow.idFormatted)
        XCTAssertEqual(shows.first?.nameFormatted, validShow.nameFormatted)
        XCTAssertEqual(shows.first?.descriptionFormatted, validShow.descriptionFormatted)
        XCTAssertEqual(shows.first?.descriptionSourceFormatted, validShow.descriptionSourceFormatted)
        XCTAssertEqual(shows.first?.countryFormatted, validShow.countryFormatted)
        XCTAssertEqual(shows.first?.startDateFormatted, validShow.startDateFormatted)
        XCTAssertEqual(shows.first?.statusFormatted, validShow.statusFormatted)
        XCTAssertEqual(shows.first?.imageStringUrlFormatted, validShow.imageStringUrlFormatted)
        XCTAssertEqual(shows.first?.genresFormatted, validShow.genresFormatted)
        XCTAssertEqual(shows.first?.numberOfSeasons, validShow.numberOfSeasons)
        XCTAssertEqual(shows.first?.numberOfEpisodes, validShow.numberOfEpisodes)
        XCTAssertEqual(shows.first?.platformFormatted, validShow.platformFormatted)
        XCTAssertEqual(shows.first?.trackedFormatted, validShow.trackedFormatted)
    }

    func testGivenAShowIsAlreadySaved_WhenSavingTheShow_ThenTheShowIsNotSavedAgain() {
        let firstShow = FakeShow.correctTvShowInfo()
        let success = watchinShowRepository.saveWatchinShow(show: firstShow)
        XCTAssertTrue(success)
        let secondShow = FakeShow.correctTvShowInfo()

        let secondSuccess = watchinShowRepository.saveWatchinShow(show: secondShow)

        let untrackedShows = watchinShowRepository.getUntrackedShows()
        let trackedShows = watchinShowRepository.getTrackedShows()
        XCTAssertFalse(secondSuccess)
        XCTAssertTrue(trackedShows.isEmpty)
        XCTAssertEqual(untrackedShows.count, 1)
        XCTAssertEqual(untrackedShows.first?.idFormatted, firstShow.idFormatted)
    }

    func testGivenAShowIsSaved_WhenDeletingTheShow_ThenTheShowIsCorrectlyDeleted() {

        let show = FakeShow.correctTvShowInfo()
        let success = watchinShowRepository.saveWatchinShow(show: show)
        XCTAssertTrue(success)

        watchinShowRepository.deleteWatchinShow(show: show)

        let untrackedShows = watchinShowRepository.getUntrackedShows()
        let trackedShows = watchinShowRepository.getTrackedShows()
        XCTAssertTrue(untrackedShows.isEmpty)
        XCTAssertTrue(trackedShows.isEmpty)
    }

    func testGivenAShowIsSaved_WhenUpdatingItsPlatform_ThenItsPlatformIsCorrectlyUpdated() {

        let show = FakeShow.correctTvShowInfo()
        let success = watchinShowRepository.saveWatchinShow(show: show)
        XCTAssertTrue(success)

        watchinShowRepository.updateWatchinShowPlatform(show: show, platform: "Netflix")
        let platformModifiedShow = watchinShowRepository.getWatchinShow(id: show.idFormatted)

        XCTAssertEqual(platformModifiedShow?.platformFormatted, "Netflix")
    }

    func testGivenAShowIsValid_WhenSavedButUntracked_ThenShowIsNowInWatchinLater() {

        let show = FakeShow.correctTvShowInfo()

        let success = watchinShowRepository.saveWatchinShow(show: show)
        XCTAssertTrue(success)

        let untrackedShows = watchinShowRepository.getUntrackedShows()
        XCTAssertEqual(untrackedShows.first?.idFormatted, show.idFormatted)
        XCTAssertTrue(watchinShowRepository.isInWatchinLater(show: show))
    }

    func testGivenAShowIsValid_WhenSavedAndTracked_ThenShowIsNowInYourShows() {

        let show = FakeShow.correctTvShowInfo()

        let success = watchinShowRepository.saveWatchinShow(show: show)
        XCTAssertTrue(success)
        watchinShowRepository.updateShowTrackedStatus(show: show)

        let trackedShows = watchinShowRepository.getTrackedShows()
        XCTAssertEqual(trackedShows.first?.idFormatted, show.idFormatted)
        XCTAssertTrue(watchinShowRepository.isInYourShows(show: show))
    }

    func testGivenAShowIsSaved_WhenUpdatingItsTrackedStatus_ThenItsTrackedStatusIsCorrectlyUpdated() {

        let show = FakeShow.correctTvShowInfo()
        let success = watchinShowRepository.saveWatchinShow(show: show)
        XCTAssertTrue(success)
        XCTAssertEqual(show.trackedFormatted, false)

        watchinShowRepository.updateShowTrackedStatus(show: show)
        let modifiedTrackedStatusShow = watchinShowRepository.getWatchinShow(id: show.idFormatted)

        XCTAssertEqual(modifiedTrackedStatusShow?.trackedFormatted, true)
    }

    func testGivenAShowIsValid_WhenSavingIt_ThenShowIsSavedAndUntracked() {

        let show = FakeShow.correctTvShowInfo()

        let success = watchinShowRepository.saveWatchinShow(show: show)

        XCTAssertTrue(success)
        XCTAssertEqual(show.trackedFormatted, false)
        let untrackedShows = watchinShowRepository.getUntrackedShows()
        XCTAssertEqual(untrackedShows.first?.idFormatted, show.idFormatted)
    }

    func testGivenAShowIsValid_WhenSavedAndUpdtatingItsTrackedStatusToTracked_ThenShowIsSavedAndTracked() {

        let show = FakeShow.correctTvShowInfo()

        let success = watchinShowRepository.saveWatchinShow(show: show)
        watchinShowRepository.updateShowTrackedStatus(show: show)

        XCTAssertTrue(success)
        let modifiedTrackedStatusShow = watchinShowRepository.getWatchinShow(id: show.idFormatted)
        XCTAssertEqual(modifiedTrackedStatusShow?.trackedFormatted, true)
        let trackedShows = watchinShowRepository.getTrackedShows()
        XCTAssertEqual(trackedShows.first?.idFormatted, modifiedTrackedStatusShow?.idFormatted)
    }

}
