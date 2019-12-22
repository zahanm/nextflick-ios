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
                    Image(row.0.image)
                        .resizable()
                        .scaledToFit()
                        .border(Color.gray)
                    if row.1 != nil {
                        Image(row.1!.image)
                            .resizable()
                            .scaledToFit()
                            .border(Color.gray)
                    } else {
                        Spacer()
                            .scaledToFit()
                    }
                }.listRowInsets(EdgeInsets())
            }
        }
    }
}

struct PosterGridScrollView_Previews: PreviewProvider {
    static var previews: some View {
        MovieGridScrollView(movies:TmdbAPI.fetchMovies())
    }
}
