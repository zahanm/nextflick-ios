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

        migrator.registerMigration("fixtures") { db in
            // Populate the players table with random data
            for m in TmdbAPI.mockMovieData() {
                let movie = Movie(name: m.name, image: m.image)
                try movie.insert(db)
            }
        }

        return migrator
    }
}
