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

    struct AddToList: Action {
        let movie: Movie
        let list: MovieList
    }

    struct RemoveFromList: Action {
        let movie: Movie
        let list: MovieList
    }
}
