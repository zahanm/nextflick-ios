//
//  Stores.swift
//  Movie Night
//
//  Created by Zahan Malkani on 12/26/19.
//  Copyright © 2019 Wildlings. All rights reserved.
//

#if DEBUG

    import SwiftUIFlux

    let sampleStore = Store<AppState>(
        reducer: appStateReducer,
        state: AppState(movies: TmdbAPI.mockMovies())
    )

#endif
