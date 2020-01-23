//
//  State.swift
//  NextFlick
//
//  Created by Zahan Malkani on 12/26/19.
//  Copyright © 2019 Wildlings. All rights reserved.
//

import SwiftUIFlux

struct AppState: FluxState {
    var movies: [Movie]

    init() {
        movies = []
    }

    #if DEBUG
        init(movies: [Movie]) {
            self.movies = movies
        }
    #endif
}
