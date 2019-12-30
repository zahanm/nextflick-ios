//
//  Person.swift
//  Movie Night
//
//  Created by Zahan Malkani on 12/30/19.
//  Copyright © 2019 Wildlings. All rights reserved.
//

import Foundation

struct Person: Identifiable {
    let id = UUID()
    let name: String
    let image: String

    /** Convenience constructor */
    init(_ p: String) {
        name = p
        image = p
    }
}
