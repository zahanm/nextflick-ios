//
//  MovieListView.swift
//  Movie Night
//
//  Created by Zahan Malkani on 12/22/19.
//  Copyright © 2019 Wildlings. All rights reserved.
//

import SwiftUI

struct MovieListView: View {
    let movies: [Movie]

    var body: some View {
        VStack {
            AvatarGroupView()

            MovieGridScrollView(movies:movies)
        }
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView(movies:TmdbAPI.fetchMovies())
    }
}
