//
//  Movie.swift
//  NextFlick
//
//  Created by Zahan Malkani on 12/22/19.
//  Copyright © 2019 Wildlings. All rights reserved.
//

import Foundation
import GRDB

struct Movie: Identifiable, Codable {
    var id: Int64?
    let name: String
    let image: String
}

/// Database access
extension Movie: FetchableRecord, TableRecord, PersistableRecord {
    private enum Columns {
        static let id = Column(CodingKeys.id)
        static let name = Column(CodingKeys.name)
        static let image = Column(CodingKeys.image)
    }

    mutating func didInsert(with rowID: Int64, for _: String?) {
        id = rowID
    }
}
