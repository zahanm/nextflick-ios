//
//  Reducers.swift
//  Movie Night
//
//  Created by Zahan Malkani on 12/26/19.
//  Copyright © 2019 Wildlings. All rights reserved.
//

import SwiftUIFlux

func appStateReducer(state: AppState, action: Action) -> AppState {
    var state = state
    switch action {
    case _ as Actions.FetchMovies:
        state.movies = TmdbAPI.mockMovies()
        return state

    default: break
    }
    return state
}
