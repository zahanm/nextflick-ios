//
//  Person.swift
//  NextFlick
//
//  Created by Zahan Malkani on 12/30/19.
//  Copyright © 2019 Wildlings. All rights reserved.
//

import Foundation
import GRDB

struct Person: Identifiable, Codable {
    var id: Int64?
    let name: String
    let image: String

    /** Convenience constructor */
    init(_ p: String) {
        name = p
        image = p
    }
}

extension Person: FetchableRecord, TableRecord, MutablePersistableRecord {
    private enum Columns {
        static let id = Column(CodingKeys.id)
        static let name = Column(CodingKeys.name)
        static let image = Column(CodingKeys.image)
    }

    mutating func didInsert(with rowID: Int64, for _: String?) {
        id = rowID
    }
}
