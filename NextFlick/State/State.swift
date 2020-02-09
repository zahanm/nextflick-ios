//
//  State.swift
//  NextFlick
//
//  Created by Zahan Malkani on 12/26/19.
//  Copyright © 2019 Wildlings. All rights reserved.
//

import GRDB
import SwiftUIFlux

struct AppState: FluxState {
    var list: MovieList?
    var movies: [Int64: Movie]
    var movielistvms: [Int64: MovieListViewModel]
    var movielistmembers: [Int64: [Person]]
    var dbQueue: DatabaseQueue

    init(_ dbQueue: DatabaseQueue) {
        self.dbQueue = dbQueue
        list = nil
        movies = [Int64: Movie]()
        movielistvms = [Int64: MovieListViewModel]()
        movielistmembers = [Int64: [Person]]()
    }
}
