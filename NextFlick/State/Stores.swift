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
        let dbQueue = try! AppDatabase.openDatabase()
        return AppState(dbQueue)
    }

#endif
