//
//  Group.swift
//  NextFlick
//
//  Created by Zahan Malkani on 12/30/19.
//  Copyright © 2019 Wildlings. All rights reserved.
//

import Foundation

struct Group: Identifiable {
    let id = UUID()
    let members: [Person]

    init(_ members: [Person]) {
        self.members = members
    }
}
