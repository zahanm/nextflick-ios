//
//  Movie.swift
//  Movie Night
//
//  Created by Zahan Malkani on 12/22/19.
//  Copyright © 2019 Wildlings. All rights reserved.
//

import Foundation

struct Movie: Identifiable {
    let id = UUID()
    let name: String
    let image: String
}
