//
//  ShowServiceTests.swift
//  WatchinTests
//
//  Created by Archeron on 08/03/2022.
//

import XCTest
@testable import Watchin

class ShowServiceTests: XCTestCase {

    private let correctSearchText = "arrow"
    private let incorrectSearchText = ""

    // MARK: - getSearchResults tests

    func testGetSearchResultsShouldCompleteSuccessfullyWithSearchResultsIfNoError() {
        let showService = ShowService(networkService: FakeNetworkService(), apiConfiguration: FakeConfiguration.correct)

        showService.getSearchResults(searchText: correctSearchText) { (result: Result<[ShowSearchDetail], Error>) in
            switch result {
            case .failure:
                XCTFail("Request should not fail")
            case .success(let result):
                XCTAssertNotNil(result)
                XCTAssertEqual(result.count, 7)
            }
        }
    }

    func testGetSearchResultsShouldFailWithErrorIfIncorrectData() {
        let showService = ShowService(networkService: FakeNetworkService(), apiConfiguration: FakeConfiguration.incorrect)

        showService.getSearchResults(searchText: correctSearchText) { (result: Result<[ShowSearchDetail], Error>) in
            switch result {
            case .failure(let error):
                XCTAssertNotNil(error)
            case .success:
                XCTFail("Request should not succeed")
            }
        }
    }

    func testGetSearchResultsShouldNotFailWithEmptySearchText() {
        let showService = ShowService(networkService: FakeNetworkService(), apiConfiguration: FakeConfiguration.correct)

        showService.getSearchResults(searchText: incorrectSearchText) { (result: Result<[ShowSearchDetail], Error>) in
            switch result {
            case .failure:
                XCTFail("Request should not fail")
            case .success(let shows):
                XCTAssertNotNil(shows)
                XCTAssertEqual(shows.count, 7)
            }
        }
    }

    // MARK: - getShowDetails tests

    func testGetShowDetailsShouldCompleteSuccessfullyWithSearchResultsIfNoError() {
        let showService = ShowService(networkService: FakeNetworkService(), apiConfiguration: FakeConfiguration.correct)

        showService.getShowDetails(for: correctSearchText) { (result: Result<TvShowInfo, Error>) in
            switch result {
            case .failure:
                XCTFail("Request should not fail")
            case .success(let result):
                XCTAssertNotNil(result)
                XCTAssertEqual(result.id, 29560)
            }
        }
    }

    func testGetShowDetailsShouldFailWithErrorIfIncorrectData() {
        let showService = ShowService(networkService: FakeNetworkService(), apiConfiguration: FakeConfiguration.incorrect)

        showService.getShowDetails(for: correctSearchText) { (result: Result<TvShowInfo, Error>) in
            switch result {
            case .failure(let error):
                XCTAssertNotNil(error)
            case .success:
                XCTFail("Request should not succeed")
            }
        }
    }
}
