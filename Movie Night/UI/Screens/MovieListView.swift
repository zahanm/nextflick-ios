//
//  MovieListView.swift
//  Movie Night
//
//  Created by Zahan Malkani on 12/22/19.
//  Copyright © 2019 Wildlings. All rights reserved.
//

import SwiftUI
import SwiftUIFlux

// MARK: View

struct MovieListView: ConnectedView {
    struct Props {
        let movies: [Movie]
    }

    func body(props: Props) -> some View {
        let group = Group(TmdbAPI.mockPeople())
        return NavigationView {
            VStack {
                AvatarGroupView(group)
                MovieGridScrollView(movies: props.movies)
            }
            .onAppear {
                self.fetchMovieDetails()
            }
        }
    }
}

// MARK: State to props

extension MovieListView {
    func map(state: AppState, dispatch _: @escaping DispatchFunction) -> Props {
        return Props(movies: state.movies)
    }
}

// MARK: Actions

extension MovieListView {
    func fetchMovieDetails() {
        appStore.dispatch(action: Actions.FetchMovies())
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
