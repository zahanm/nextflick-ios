//
//  Reducers.swift
//  NextFlick
//
//  Created by Zahan Malkani on 12/26/19.
//  Copyright © 2019 Wildlings. All rights reserved.
//

import GRDB
import SwiftUI
import SwiftUIFlux

func appStateReducer(state: AppState, action: Action) -> AppState {
    var state = state
    switch action {
    case _ as Actions.FetchMovies:
        let movies = try! state.dbQueue.read { db in
            try Movie.all().fetchAll(db)
        }
        state.movies = Dictionary(uniqueKeysWithValues: movies.map { ($0.id!, $0) })
        return state

    case let action as Actions.AddToList:
        try! state.dbQueue.write { db in
            var assoc = MovieListAssoc(movieId: action.movie.id!, listId: action.list.id!)
            try assoc.insert(db)
        }
        return state

    case let action as Actions.RemoveFromList:
        try! state.dbQueue.write { db in
            let assoc = MovieListAssoc(movieId: action.movie.id!, listId: action.list.id!)
            try assoc.delete(db)
        }
        return state

    default: break
    }
    return state
}
