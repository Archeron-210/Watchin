//
//  TvShowInfoFormattedTests.swift
//  WatchinTests
//
//  Created by Archeron on 09/03/2022.
//

import XCTest
@testable import Watchin

class TvShowInfoFormattedTests: XCTestCase {

    var correctTestShow: ShowDetailFormatted?
    var incorrectTestShow: ShowDetailFormatted?

    override func setUp() {
        super.setUp()
        correctTestShow = FakeShow.correctTvShowInfo()
        incorrectTestShow = FakeShow.incorrectTvShowInfo()
    }

    override func tearDown() {
        super.tearDown()
        correctTestShow = nil
        incorrectTestShow = nil
    }

}
