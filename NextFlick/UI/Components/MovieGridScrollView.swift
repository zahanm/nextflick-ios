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
    @Binding var showDetail: Bool
    @Binding var showDetailMovie: Movie?

    var body: some View {
        List {
            ForEach(movies) { movie in
                self.showPosterFor(movie)
            }
            .listRowBackground(Constants.bgGreen)
        }
    }

    func showPosterFor(_ movie: Movie) -> some View {
        Image(movie.image)
            .resizable()
            .scaledToFit()
            .onTapGesture {
                self.showDetail = true
                self.showDetailMovie = movie
            }
    }
}

struct PosterGridScrollView_Previews: PreviewProvider {
    @State static var showDetail = false
    @State static var showDetailMovie: Movie? = nil
    static var previews: some View {
        MovieGridScrollView(movies: TmdbAPI.mockMovies(), showDetail: $showDetail, showDetailMovie: $showDetailMovie)
    }
}
