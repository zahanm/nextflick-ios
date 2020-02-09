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

    case let action as Actions.FetchMovieListMembership:
        let listvms = try! state.dbQueue.read { db -> [MovieListViewModel] in
            let lists = try MovieList.fetchAll(db)
            return try lists.map { list in
                let count = try MovieListAssoc.filter(Column("movieId") == action.movie.id!)
                    .filter(Column("listId") == list.id!)
                    .fetchCount(db)
                assert(count == 0 || count == 1)
                return MovieListViewModel(movie: action.movie, list: list, isMember: count > 0)
            }
        }
        state.movielistvms = Dictionary(uniqueKeysWithValues: listvms.map { ($0.list.id!, $0) })
        return state

    case let action as Actions.AddToList:
        print(action)
        state.movielistvms[action.list.id!]!.isMember = true
        print(state)
        return state

    case let action as Actions.RemoveFromList:
        state.movielistvms[action.list.id!]!.isMember = false
        return state

    default: break
    }
    return state
}
