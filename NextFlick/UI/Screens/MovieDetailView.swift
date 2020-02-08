//
//  MovieDetailView.swift
//  NextFlick
//
//  Created by Zahan Malkani on 12/22/19.
//  Copyright © 2019 Wildlings. All rights reserved.
//

import GRDB
import SwiftUI
import SwiftUIFlux

struct MovieDetailView: View {
    @EnvironmentObject var store: Store<AppState>
    let movie: Movie

    var listvms: [MovieListViewModel] {
        try! store.state.dbQueue.read { db -> [MovieListViewModel] in
            let lists = try MovieList.fetchAll(db)
            return try lists.map { list in
                let count = try MovieListAssoc.filter(Column("movieId") == movie.id!)
                    .filter(Column("listId") == list.id!)
                    .fetchCount(db)
                assert(count == 0 || count == 1)
                let boundIsMember = Binding<Bool>(
                    get: { count > 0 },
                    set: {
                        if $0 {
                            self.store.dispatch(action: Actions.AddToList(movie: self.movie, list: list))
                        } else {
                            self.store.dispatch(action: Actions.RemoveFromList(movie: self.movie, list: list))
                        }
                    }
                )
                return MovieListViewModel(movie: movie, list: list, isMember: boundIsMember)
            }
        }
    }

    var body: some View {
        return ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading) {
                Image(movie.image)
                    .resizable()
                    .scaledToFit()

                Text("Add / remove from lists")
                    .font(.headline)
                    .foregroundColor(.white)

                ForEach(listvms, id: \.self.list.id) { listvm in
                    MovieListToggle(group: listvm.list, isInList: listvm.isMember)
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
