//
//  TmdbAPI.swift
//  Movie Night
//
//  Created by Zahan Malkani on 12/22/19.
//  Copyright © 2019 Wildlings. All rights reserved.
//

struct TmdbAPI {
    static func mockMovies() -> [Movie] {
        [
            Movie(name: "Joker", image: "joker"),
            Movie(name: "The Favourite", image: "favourite"),
            Movie(name: "Ford v. Ferrari", image: "ford-v-ferrari"),
            Movie(name: "Green Book", image: "green-book"),
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
