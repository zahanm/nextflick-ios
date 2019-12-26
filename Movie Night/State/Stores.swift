//
//  Stores.swift
//  Movie Night
//
//  Created by Zahan Malkani on 12/26/19.
//  Copyright © 2019 Wildlings. All rights reserved.
//

import SwiftUIFlux

let appStore = Store<AppState>(
    reducer: appStateReducer,
    state: AppState()
)

#if DEBUG

    let sampleStore = Store<AppState>(
        reducer: appStateReducer,
        state: AppState(movies: TmdbAPI.mockMovies())
    )

#endif
