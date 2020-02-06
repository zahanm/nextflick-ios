//
//  Group.swift
//  NextFlick
//
//  Created by Zahan Malkani on 12/30/19.
//  Copyright © 2019 Wildlings. All rights reserved.
//

import Foundation
import GRDB

struct Group: Identifiable, Codable {
    var id: Int64?
}

/// The database setup for this model is less straightforward than the others.
/// Namely, I'm going to store this "assoc" style, with a (group-id, member-id) table.
/// Then, I'll have to query from that to build up this model.
extension Group: FetchableRecord, MutablePersistableRecord {
    var members: QueryInterfaceRequest<Person> {
        return request(for: Group.members)
    }

    var movies: QueryInterfaceRequest<Movie> {
        return request(for: Group.movies)
    }

    mutating func didInsert(with rowID: Int64, for _: String?) {
        id = rowID
    }

    static let memberAssocs = hasMany(PersonGroupAssoc.self)
    static let members = hasMany(Person.self, through: memberAssocs, using: PersonGroupAssoc.person)

    static let movieAssocs = hasMany(MovieGroupAssoc.self)
    static let movies = hasMany(Movie.self, through: movieAssocs, using: MovieGroupAssoc.movie)
}

struct PersonGroupAssoc: Codable, MutablePersistableRecord {
    var personId: Int64
    static let person = belongsTo(Person.self)
    var groupId: Int64
    static let group = belongsTo(Group.self)
}

extension Person {
    static let memberAssocs = hasMany(PersonGroupAssoc.self)
    static let groups = hasMany(Group.self, through: memberAssocs, using: PersonGroupAssoc.group)
    var groups: QueryInterfaceRequest<Group> {
        return request(for: Person.groups)
    }
}

struct MovieGroupAssoc: Codable, MutablePersistableRecord {
    var movieId: Int64
    static let movie = belongsTo(Movie.self)
    var groupId: Int64
    static let group = belongsTo(Group.self)
}

extension Movie {
    static let groupAssocs = hasMany(MovieGroupAssoc.self)
    static let groups = hasMany(Group.self, through: groupAssocs, using: MovieGroupAssoc.group)
    var groups: QueryInterfaceRequest<Group> {
        return request(for: Movie.groups)
    }
}
