//
//  MovieListView.swift
//  NextFlick
//
//  Created by Zahan Malkani on 12/22/19.
//  Copyright © 2019 Wildlings. All rights reserved.
//

import SwiftUI
import SwiftUIFlux

// MARK: View

struct MovieListView: ConnectedView {
    @EnvironmentObject var store: Store<AppState>
    @State var showDetailMovie: Movie? = nil

    struct Props {
        let movies: [Movie]
    }

    func body(props: Props) -> some View {
        let showDetail = Binding<Bool>(
            get: { self.showDetailMovie != nil },
            set: { _ in () }
        )
        let group = try! store.state.dbQueue.read { db in
            try MovieList.all().fetchOne(db)!
        }
        return ZStack {
            Color("dark-olive")
                .edgesIgnoringSafeArea(.all)

            VStack {
                MovieListAvatarsView(group)
                    .frame(height: 50)

                MovieGridScrollView(movies: props.movies, showDetailMovie: $showDetailMovie)
            }
            .onAppear {
                self.fetchMovieDetails()
            }
            .padding(0)
            .edgesIgnoringSafeArea(.bottom)
            .sheet(isPresented: showDetail) {
                StoreProvider(store: self.store) {
                    MovieDetailView(movie: self.showDetailMovie!)
                }
            }
        }
    }
}

// MARK: State to props

extension MovieListView {
    func map(state: AppState, dispatch _: @escaping DispatchFunction) -> Props {
        return Props(movies: state.movies.map { $1 }.sorted { $0.name < $1.name })
    }
}

// MARK: Actions

extension MovieListView {
    func fetchMovieDetails() {
        store.dispatch(action: Actions.FetchMovies())
    }
}

// MARK: Preview

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        StoreProvider(store: sampleStore) {
            MovieListView()
        }
    }
}
