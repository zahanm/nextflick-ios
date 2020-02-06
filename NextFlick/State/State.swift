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
    var movies: [Movie]
    var dbQueue: DatabaseQueue

    init(_ dbQueue: DatabaseQueue) {
        self.dbQueue = dbQueue
        movies = []
    }

    #if DEBUG
        init(_ dbQueue: DatabaseQueue, movies: [Movie]) {
            self.dbQueue = dbQueue
            self.movies = movies
        }
    #endif
}
