//
//  TmdbAPI.swift
//  NextFlick
//
//  Created by Zahan Malkani on 12/22/19.
//  Copyright © 2019 Wildlings. All rights reserved.
//

struct TmdbAPI {
    static func mockMovieData() -> [(name: String, image: String)] {
        [
            (name: "Joker", image: "joker"),
            (name: "The Favourite", image: "favourite"),
            (name: "Ford v. Ferrari", image: "ford-v-ferrari"),
            (name: "Green Book", image: "green-book"),
            (name: "Joker 2", image: "joker"),
        ]
    }

    static func mockPeopleData() -> [String] {
        [
            "Zahan",
            "Vibha",
            "Ollie",
        ]
    }
}
