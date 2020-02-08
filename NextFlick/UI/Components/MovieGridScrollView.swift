//
//  MovieGridScrollView.swift
//  NextFlick
//
//  Created by Zahan Malkani on 12/22/19.
//  Copyright © 2019 Wildlings. All rights reserved.
//

import SwiftUI

struct MovieGridScrollView: View {
    let movies: [Movie]
    @Binding var showDetailMovie: Movie?

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
                HStack(spacing: 2) {
                    self.showPosterFor(row.0)
                    if row.1 != nil {
                        self.showPosterFor(row.1!)
                    } else {
                        Spacer()
                            .scaledToFit()
                    }
                }
            }
            .listRowBackground(Color("dark-olive"))
            .listRowInsets(EdgeInsets(top: 1, leading: 6, bottom: 1, trailing: 6))
        }
    }

    func showPosterFor(_ movie: Movie) -> some View {
        Image(movie.image)
            .resizable()
            .scaledToFit()
            .cornerRadius(2)
            .onTapGesture {
                self.showDetailMovie = movie
            }
    }
}

struct PosterGridScrollView_Previews: PreviewProvider {
    @State static var showDetailMovie: Movie? = nil
    static var previews: some View {
        let movies = try! sampleStore.state.dbQueue.read { db in
            try Movie.all().fetchAll(db)
        }
        return MovieGridScrollView(movies: movies, showDetailMovie: $showDetailMovie)
    }
}
