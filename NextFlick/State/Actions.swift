//
//  Actions.swift
//  NextFlick
//
//  Created by Zahan Malkani on 12/26/19.
//  Copyright © 2019 Wildlings. All rights reserved.
//

import GRDB
import SwiftUI
import SwiftUIFlux

struct Actions {
    struct FetchMovies: Action {}

    struct FetchMovieListMembership: Action {
        let movie: Movie
    }

    struct AddToList: AsyncAction {
        let movie: Movie
        let list: MovieList

        func execute(state: FluxState?, dispatch _: @escaping DispatchFunction) {
            let appState = state as! AppState
            appState.dbQueue.asyncWrite({ db in
                var assoc = MovieListAssoc(movieId: self.movie.id!, listId: self.list.id!)
                try assoc.insert(db)
            }, completion: { _, result in
                switch result {
                case .success:
                    print("all good")
                case let .failure(error):
                    print("error add \(error)")
                    // dispatch(Actions.RemoveFromList(movie: movie, list: list)) // make this an error action
                }
            })
        }
    }

    struct RemoveFromList: AsyncAction {
        let movie: Movie
        let list: MovieList

        func execute(state: FluxState?, dispatch _: @escaping DispatchFunction) {
            let appState = state as! AppState
            do {
                try appState.dbQueue.write { db in
                    let assoc = MovieListAssoc(movieId: movie.id!, listId: list.id!)
                    try assoc.delete(db)
                }
            } catch {
                print("error remove")
                // dispatch(Actions.AddToList(movie: movie, list: list)) // make this an error action
            }
        }
    }
}
