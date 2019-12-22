//
//  TmdbAPI.swift
//  Movie Night
//
//  Created by Zahan Malkani on 12/22/19.
//  Copyright © 2019 Wildlings. All rights reserved.
//

struct TmdbAPI {

    static func fetchMovies() -> [Movie] {
        [
            Movie(id: 0, name: "Joker", image: "joker"),
            Movie(id: 1, name: "The Favourite", image: "favourite"),
            Movie(id: 2, name: "Ford v. Ferrari", image: "ford-v-ferrari"),
            Movie(id: 3, name: "Green Book", image: "green-book"),
            Movie(id: 4, name: "The Favourite", image: "favourite"),
            Movie(id: 5, name: "Joker", image: "joker"),
            Movie(id: 6, name: "Green Book", image: "green-book"),
        ]
    }
}
