//
//  MovieListViewModel.swift
//  NextFlick
//
//  Created by Zahan Malkani on 2/8/20.
//  Copyright © 2020 Wildlings. All rights reserved.
//

import SwiftUI

struct MovieListViewModel {
    let movie: Movie
    let list: MovieList
    var isMember: Binding<Bool>
}
