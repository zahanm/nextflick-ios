//
//  MovieDetailView.swift
//  NextFlick
//
//  Created by Zahan Malkani on 12/22/19.
//  Copyright © 2019 Wildlings. All rights reserved.
//

import SwiftUI
import SwiftUIFlux

struct MovieDetailView: View {
    @EnvironmentObject var store: Store<AppState>
    let movie: Movie

    var body: some View {
        let groups = try! store.state.dbQueue.read { db in
            try movie.groups.fetchAll(db)
        }
        return ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading) {
                Image(movie.image)
                    .resizable()
                    .scaledToFit()

                Text("Add / remove from lists")
                    .font(.headline)
                    .foregroundColor(.white)

                ForEach(groups) { g in
                    GroupToggle(group: g, isInList: .constant(true))
                        .frame(height: 56)
                }
            }.padding(30)
        }
        .background(Color("dark-olive"))
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let movie = try! sampleStore.state.dbQueue.read { db in
            try Movie.all().fetchOne(db)!
        }
        return StoreProvider(store: sampleStore) {
            MovieDetailView(movie: movie)
        }
    }
}
