//
//  MovieDetailView.swift
//  Movie Night
//
//  Created by Zahan Malkani on 12/22/19.
//  Copyright © 2019 Wildlings. All rights reserved.
//

import SwiftUI

struct MovieDetailView: View {
    let movie: Movie

    var body: some View {
        VStack {
            Image(movie.image)

            VStack {
                Text("Add to shared movie list")

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach([1...3], id: \.self) { list in
                            AvatarGroupView()
                        }
                    }
                }
                .frame(height: 60)
            }

            VStack {
                Text("Recommend 1:1")

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach([1...3], id: \.self) { list in
                            CircularAvatarView(person: "zahan", diameter: 50)
                        }
                    }
                }
                .frame(height: 60)
            }
            }.padding()
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movie: TmdbAPI.mockMovies()[0])
    }
}
