//
//  AppDatabase.swift
//  NextFlick
//
//  Created by Zahan Malkani on 1/29/20.
//  Copyright © 2020 Wildlings. All rights reserved.
//

import Foundation
import GRDB

struct AppDatabase {
    /// Creates a fully initialized database at path
    static func openDatabase(atPath path: String) throws -> DatabaseQueue {
        let dbQueue = try DatabaseQueue(path: path)
        try migrator.migrate(dbQueue)
        return dbQueue
    }

    /// The DatabaseMigrator that defines the database schema.
    ///
    /// See https://github.com/groue/GRDB.swift/blob/master/README.md#migrations
    static var migrator: DatabaseMigrator {
        var migrator = DatabaseMigrator()

        migrator.registerMigration("createMovie") { db in
            try db.create(table: "movie") { t in
                t.autoIncrementedPrimaryKey("id")
                t.column("name", .text).notNull()
                t.column("image", .text).notNull()
            }
        }

        migrator.registerMigration("createPerson") { db in
            try db.create(table: "person") { t in
                t.autoIncrementedPrimaryKey("id")
                t.column("name", .text).notNull()
                t.column("image", .text).notNull()
            }
        }

        migrator.registerMigration("fixtures-movies") { db in
            // Populate the players table with starter
            for m in TmdbAPI.mockMovieData() {
                var movie = Movie(name: m.name, image: m.image)
                try movie.insert(db)
            }
        }

        migrator.registerMigration("fixtures-people") { db in
            for p in TmdbAPI.mockPeopleData() {
                var person = Person(p)
                try person.insert(db)
            }
        }

        migrator.registerMigration("create-group") { db in
            try db.create(table: "groupv2") { t in
                t.autoIncrementedPrimaryKey("id")
            }
        }

        migrator.registerMigration("create-person-group-assoc") { db in
            try db.create(table: "persongroupmembership") { t in
                t.column("personId", .integer).notNull().references("person")
                t.column("groupId", .integer).notNull().references("groupv2")
                t.primaryKey(["personId", "groupId"])
                t.uniqueKey(["groupId", "personId"])
            }
        }

        migrator.registerMigration("create-movie-group-assoc") { db in
            try db.create(table: "moviegroupassoc") { t in
                t.column("movieId", .integer).notNull().references("movie")
                t.column("groupId", .integer).notNull().references("groupv2")
                t.primaryKey(["movieId", "groupId"])
                t.uniqueKey(["groupId", "movieId"])
            }
        }

        migrator.registerMigration("fixtures-groups-with-fillings") { db in
            let people = try Person.all().fetchAll(db)
            assert(people.count == 3)
            let movies = try Movie.all().fetchAll(db)
            assert(movies.count == 5)
            // group 1 has first two people as members
            var g1 = GroupV2()
            try g1.insert(db)
            var assoc = PersonGroupMembership(personId: people[0].id!, groupId: g1.id!)
            try assoc.insert(db)
            assoc = PersonGroupMembership(personId: people[1].id!, groupId: g1.id!)
            try assoc.insert(db)
            // group 1 has 2 movies
            var movieGroupAssoc = MovieGroupAssoc(movieId: movies[0].id!, groupId: g1.id!)
            try movieGroupAssoc.insert(db)
            movieGroupAssoc = MovieGroupAssoc(movieId: movies[1].id!, groupId: g1.id!)
            try movieGroupAssoc.insert(db)
            // group 2 has all three people as members
            var g2 = GroupV2()
            try g2.insert(db)
            assoc = PersonGroupMembership(personId: people[0].id!, groupId: g2.id!)
            try assoc.insert(db)
            assoc = PersonGroupMembership(personId: people[1].id!, groupId: g2.id!)
            try assoc.insert(db)
            assoc = PersonGroupMembership(personId: people[2].id!, groupId: g2.id!)
            try assoc.insert(db)
            // group 2 has 4 movies
            movieGroupAssoc = MovieGroupAssoc(movieId: movies[4].id!, groupId: g2.id!)
            try movieGroupAssoc.insert(db)
            movieGroupAssoc = MovieGroupAssoc(movieId: movies[3].id!, groupId: g2.id!)
            try movieGroupAssoc.insert(db)
            movieGroupAssoc = MovieGroupAssoc(movieId: movies[2].id!, groupId: g2.id!)
            try movieGroupAssoc.insert(db)
            movieGroupAssoc = MovieGroupAssoc(movieId: movies[1].id!, groupId: g2.id!)
            try movieGroupAssoc.insert(db)
        }

        return migrator
    }
}
