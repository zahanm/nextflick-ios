//
//  MovieDetailView.swift
//  NextFlick
//
//  Created by Zahan Malkani on 12/22/19.
//  Copyright © 2019 Wildlings. All rights reserved.
//

import SwiftUI

struct MovieDetailView: View {
    let movie: Movie

    var body: some View {
        let people = TmdbAPI.mockPeople()
        let groups = [
            Group(Array(people.shuffled().prefix(2))),
            Group(Array(people.shuffled().prefix(2))),
            Group(people),
        ]
        return VStack {
            Image(movie.image)

            VStack {
                Text("Add to shared movie list")

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(groups) { g in
                            GroupAvatarView(g)
                                .scaledToFit()
                                .frame(height: 60)
                            // these don't help
                            // .fixedSize(horizontal: false, vertical: true)
                            // .layoutPriority(Double(g.members.count))
                        }
                    }
                }
            }

            VStack {
                Text("Recommend 1:1")

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(people) { p in
                            SingleAvatarView(person: p)
                                .frame(height: 60)
                        }
                    }
                }
            }
        }.padding()
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movie: TmdbAPI.mockMovies()[0])
    }
}
