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

struct MovieDetailView: ConnectedView {
    let movie: Movie

    struct Props {
        let listvms: [MovieListViewModel]
        let toggleActions: [Int64: Binding<Bool>]
        let fetchMemberships: () -> Void
    }

    func body(props: Props) -> some View {
        return ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading) {
                Image(movie.image)
                    .resizable()
                    .scaledToFit()

                Text("Add / remove from lists")
                    .font(.headline)
                    .foregroundColor(.white)

                ForEach(props.listvms, id: \.self.list.id) { listvm in
                    MovieListToggle(group: listvm.list, isInList: props.toggleActions[listvm.list.id!]!)
                        .frame(height: 56)
                }
            }.padding(30)
        }
        .onAppear {
            props.fetchMemberships()
        }
        .background(Color("dark-olive"))
        .edgesIgnoringSafeArea(.bottom)
    }
}

// MARK: State to props

extension MovieDetailView {
    func map(state: AppState, dispatch: @escaping DispatchFunction) -> Props {
        let listvms = state.movielistvms.map { $1 }.sorted(by: { $0.list.id! < $1.list.id! })
        let toggleActions = state.movielistvms.mapValues { listvm -> Binding<Bool> in
            Binding(
                get: { listvm.isMember },
                set: {
                    if $0 {
                        dispatch(Actions.AddToList(movie: listvm.movie, list: listvm.list))
                    } else {
                        dispatch(Actions.RemoveFromList(movie: listvm.movie, list: listvm.list))
                    }
                }
            )
        }
        return Props(listvms: listvms, toggleActions: toggleActions, fetchMemberships: {
            dispatch(Actions.FetchMovieListMembership(movie: self.movie))
        })
    }
}

#if DEBUG
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
#endif
