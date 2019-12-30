//
//  PosterGridScrollView.swift
//  Movie Night
//
//  Created by Zahan Malkani on 12/22/19.
//  Copyright © 2019 Wildlings. All rights reserved.
//

import SwiftUI

struct MovieGridScrollView: View {
    let movies: [Movie]

    var body: some View {
        List(movies) { movie in
            self.showPosterFor(movie)
                .listRowInsets(EdgeInsets())
        }
    }

    func showPosterFor(_ movie: Movie) -> some View {
        NavigationLink(destination: MovieDetailView(movie: movie)) {
            Image(movie.image)
                .resizable()
                .scaledToFit()
        }
    }
}

struct PosterGridScrollView_Previews: PreviewProvider {
    static var previews: some View {
        MovieGridScrollView(movies: TmdbAPI.mockMovies())
    }
}
