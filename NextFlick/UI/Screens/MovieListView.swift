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
    // TODO: need to figure out how to make a Binding of
    // a Bool expression, so that I can remove showDetail
    @State var showDetail = false
    @State var showDetailMovie: Movie? = nil

    struct Props {
        let list: MovieList?
        let movies: [Movie]
    }

    func body(props: Props) -> some View {
        return ZStack {
            Color("dark-olive")
                .edgesIgnoringSafeArea(.all)

            VStack {
                if props.list != nil {
                    MovieListAvatarsView(props.list!)
                        .frame(height: 50)
                }

                MovieGridScrollView(movies: props.movies, showDetail: $showDetail, showDetailMovie: $showDetailMovie)
            }
            .onAppear {
                self.fetchMovieDetails()
            }
            .padding(0)
            .edgesIgnoringSafeArea(.bottom)
            .sheet(isPresented: $showDetail) {
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
        return Props(
            list: state.list,
            movies: state.movies.map { $1 }.sorted { $0.name < $1.name }
        )
    }
}

// MARK: Actions

extension MovieListView {
    func fetchMovieDetails() {
        store.dispatch(action: Actions.FetchMovies())
    }
}

// MARK: Preview

#if DEBUG
    struct MovieListView_Previews: PreviewProvider {
        static var previews: some View {
            StoreProvider(store: sampleStore) {
                MovieListView()
            }
        }
    }
#endif
