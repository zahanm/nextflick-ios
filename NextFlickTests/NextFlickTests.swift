//
//  NextFlickTests.swift
//  NextFlickTests
//
//  Created by Zahan Malkani on 12/1/19.
//  Copyright © 2019 Wildlings. All rights reserved.
//

import GRDB
@testable import NextFlick
import XCTest

class NextFlickTests: XCTestCase {
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testDatabase() {
        let databaseURL = try! FileManager.default
            .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent("db.sqlite")
        let dbQueue = try! AppDatabase.openDatabase(atPath: databaseURL.path)
        print(dbQueue.path)
        let mockMovieData = TmdbAPI.mockMovieData()
        let mockPeopleData = TmdbAPI.mockPeopleData()
        try! dbQueue.read { db in
            let numberOfRecords = try Movie.fetchCount(db)
            assert(numberOfRecords == mockMovieData.count)

            let m = try Movie.all().filter(Column("image") == mockMovieData[2].image).fetchOne(db)
            assert(m!.name == mockMovieData[2].name)

            let p = try Person.all().filter(Column("image") == mockPeopleData[1]).fetchOne(db)
            assert(p!.name == mockPeopleData[1])

            let pMembershipCount = try p!.lists.fetchCount(db)
            assert(pMembershipCount > 0)

            let mListCount = try m!.lists.fetchCount(db)
            assert(mListCount > 0)
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}
