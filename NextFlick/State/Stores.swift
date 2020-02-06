//
//  Stores.swift
//  NextFlick
//
//  Created by Zahan Malkani on 12/26/19.
//  Copyright © 2019 Wildlings. All rights reserved.
//

#if DEBUG

    import Foundation
    import SwiftUIFlux

    let sampleStore = Store<AppState>(
        reducer: appStateReducer,
        state: setupSampleState()
    )

    func setupSampleState() -> AppState {
        let databaseURL = try! FileManager.default
            .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent("db.sqlite")
        let dbQueue = try! AppDatabase.openDatabase(atPath: databaseURL.path)
        return AppState(dbQueue, movies: TmdbAPI.mockMovies())
    }

#endif
