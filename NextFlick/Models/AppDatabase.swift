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

    #if DEBUG
        static func openDatabase() throws -> DatabaseQueue {
            let dbQueue = DatabaseQueue()
            try migrator.migrate(dbQueue)
            return dbQueue
        }
    #endif

    /// The DatabaseMigrator that defines the database schema.
    ///
    /// See https://github.com/groue/GRDB.swift/blob/master/README.md#migrations
    static var migrator: DatabaseMigrator {
        var migrator = DatabaseMigrator()
        #if DEBUG
            // Speed up development by nuking the database when migrations change
            migrator.eraseDatabaseOnSchemaChange = true
        #endif

        migrator.registerMigration("create-movies") { db in
            try db.create(table: "movie") { t in
                t.autoIncrementedPrimaryKey("id")
                t.column("name", .text).notNull()
                t.column("image", .text).notNull()
            }
        }

        migrator.registerMigration("create-people") { db in
            try db.create(table: "person") { t in
                t.autoIncrementedPrimaryKey("id")
                t.column("name", .text).notNull()
                t.column("image", .text).notNull()
            }
        }

        migrator.registerMigration("create-lists") { db in
            try db.create(table: "movielist") { t in
                t.autoIncrementedPrimaryKey("id")
            }
        }

        migrator.registerMigration("create-person-list-assoc") { db in
            try db.create(table: "personlistassoc") { t in
                t.column("personId", .integer).notNull().references("person")
                t.column("listId", .integer).notNull().references("movielist")
                t.primaryKey(["personId", "listId"])
                t.uniqueKey(["listId", "personId"])
            }
        }

        migrator.registerMigration("create-movie-list-assoc") { db in
            try db.create(table: "movielistassoc") { t in
                t.column("movieId", .integer).notNull().references("movie")
                t.column("listId", .integer).notNull().references("movielist")
                t.primaryKey(["movieId", "listId"])
                t.uniqueKey(["listId", "movieId"])
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

        migrator.registerMigration("fixtures-lists-with-fillings") { db in
            let people = try Person.all().fetchAll(db)
            assert(people.count == 3)
            let movies = try Movie.all().fetchAll(db)
            assert(movies.count == 5)
            // list 1 has first two people as members
            var g1 = MovieList()
            try g1.insert(db)
            var assoc = PersonListAssoc(personId: people[0].id!, listId: g1.id!)
            try assoc.insert(db)
            assoc = PersonListAssoc(personId: people[1].id!, listId: g1.id!)
            try assoc.insert(db)
            // list 1 has 2 movies
            var movieGroupAssoc = MovieListAssoc(movieId: movies[0].id!, listId: g1.id!)
            try movieGroupAssoc.insert(db)
            movieGroupAssoc = MovieListAssoc(movieId: movies[1].id!, listId: g1.id!)
            try movieGroupAssoc.insert(db)
            // list 2 has all three people as members
            var g2 = MovieList()
            try g2.insert(db)
            assoc = PersonListAssoc(personId: people[0].id!, listId: g2.id!)
            try assoc.insert(db)
            assoc = PersonListAssoc(personId: people[1].id!, listId: g2.id!)
            try assoc.insert(db)
            assoc = PersonListAssoc(personId: people[2].id!, listId: g2.id!)
            try assoc.insert(db)
            // list 2 has 4 movies
            movieGroupAssoc = MovieListAssoc(movieId: movies[4].id!, listId: g2.id!)
            try movieGroupAssoc.insert(db)
            movieGroupAssoc = MovieListAssoc(movieId: movies[3].id!, listId: g2.id!)
            try movieGroupAssoc.insert(db)
            movieGroupAssoc = MovieListAssoc(movieId: movies[2].id!, listId: g2.id!)
            try movieGroupAssoc.insert(db)
            movieGroupAssoc = MovieListAssoc(movieId: movies[1].id!, listId: g2.id!)
            try movieGroupAssoc.insert(db)
        }

        return migrator
    }
}
