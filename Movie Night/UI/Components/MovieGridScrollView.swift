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
        var grouped: [(Movie, Movie?)] = []
        for i in stride(from: 0, to: movies.count, by: 2) {
            var second: Movie?
            if i + 1 < movies.count {
                second = movies[i + 1]
            } else {
                second = nil
            }
            grouped.append((movies[i], second))
        }

        return List {
            ForEach(grouped, id: \.0.id) { row in
                HStack(spacing: 0) {
                    self.showPosterFor(row.0)
                    if row.1 != nil {
                        self.showPosterFor(row.1!)
                    } else {
                        Spacer()
                            .scaledToFit()
                    }
                }
                .listRowInsets(EdgeInsets())
            }
        }
    }

    func showPosterFor(_ movie: Movie) -> some View {
        NavigationLink(destination: MovieDetailView(movie: movie)) {
            Image(movie.image)
                .resizable()
                .scaledToFit()
                .border(Color.gray)
        }
    }
}

struct PosterGridScrollView_Previews: PreviewProvider {
    static var previews: some View {
        MovieGridScrollView(movies: TmdbAPI.mockMovies())
    }
}
