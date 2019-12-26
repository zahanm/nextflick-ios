//
//  Stores.swift
//  Movie Night
//
//  Created by Zahan Malkani on 12/26/19.
//  Copyright © 2019 Wildlings. All rights reserved.
//

#if DEBUG

    import SwiftUIFlux

    private let state = AppState(movies: TmdbAPI.mockMovies())
    let sampleStore = Store<AppState>(reducer: appStateReducer, state: state)

#endif
