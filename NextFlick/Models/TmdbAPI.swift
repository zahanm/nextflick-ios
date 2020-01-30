//
//  TmdbAPI.swift
//  NextFlick
//
//  Created by Zahan Malkani on 12/22/19.
//  Copyright © 2019 Wildlings. All rights reserved.
//

struct TmdbAPI {
    static func mockMovies() -> [Movie] {
        mockMovieData().map { m in
            Movie(name: m.name, image: m.image)
        }
    }

    static func mockMovieData() -> [(name: String, image: String)] {
        [
            (name: "Joker", image: "joker"),
            (name: "The Favourite", image: "favourite"),
            (name: "Ford v. Ferrari", image: "ford-v-ferrari"),
            (name: "Green Book", image: "green-book"),
            (name: "Joker 2", image: "joker"),
        ]
    }

    static func mockPeople() -> [Person] {
        [
            Person("Zahan"),
            Person("Vibha"),
            Person("Ollie"),
        ]
    }
}
