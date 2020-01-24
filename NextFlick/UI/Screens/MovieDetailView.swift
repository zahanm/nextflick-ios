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
        return ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading) {
                Image(movie.image)
                    .resizable()
                    .scaledToFit()

                Text("Add / remove from lists")
                    .font(.headline)
                    .colorInvert()

                ForEach(groups) { g in
                    GroupAvatarView(g)
                        .frame(height: 70)
                }
            }.padding(30)
        }
        .background(Constants.bgGreen)
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movie: TmdbAPI.mockMovies()[0])
    }
}
