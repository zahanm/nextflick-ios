//
//  Group.swift
//  NextFlick
//
//  Created by Zahan Malkani on 12/30/19.
//  Copyright © 2019 Wildlings. All rights reserved.
//

import Foundation
import GRDB

struct MovieList: Identifiable, Codable {
    var id: Int64?
}

/// The database setup for this model is less straightforward than the others.
/// Namely, I'm going to store this "assoc" style, with a (list-id, member-id) table.
/// Then, I'll have to query from that to build up this model.
extension MovieList: FetchableRecord, MutablePersistableRecord {
    var members: QueryInterfaceRequest<Person> {
        return request(for: MovieList.members)
    }

    var movies: QueryInterfaceRequest<Movie> {
        return request(for: MovieList.movies)
    }

    mutating func didInsert(with rowID: Int64, for _: String?) {
        id = rowID
    }

    static let memberAssocs = hasMany(PersonListAssoc.self)
    static let members = hasMany(Person.self, through: memberAssocs, using: PersonListAssoc.person)

    static let movieAssocs = hasMany(MovieListAssoc.self)
    static let movies = hasMany(Movie.self, through: movieAssocs, using: MovieListAssoc.movie)
}

struct PersonListAssoc: Codable, MutablePersistableRecord {
    var personId: Int64
    static let person = belongsTo(Person.self)
    var listId: Int64
    static let list = belongsTo(MovieList.self)
}

extension Person {
    static let memberAssocs = hasMany(PersonListAssoc.self)
    static let lists = hasMany(MovieList.self, through: memberAssocs, using: PersonListAssoc.list)
    var lists: QueryInterfaceRequest<MovieList> {
        return request(for: Person.lists)
    }
}

struct MovieListAssoc: Codable, MutablePersistableRecord {
    var movieId: Int64
    static let movie = belongsTo(Movie.self)
    var listId: Int64
    static let list = belongsTo(MovieList.self)
}

extension Movie {
    static let listAssocs = hasMany(MovieListAssoc.self)
    static let lists = hasMany(MovieList.self, through: listAssocs, using: MovieListAssoc.list)
    var lists: QueryInterfaceRequest<MovieList> {
        return request(for: Movie.lists)
    }
}
