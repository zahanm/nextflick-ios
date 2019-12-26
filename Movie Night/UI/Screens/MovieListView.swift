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
        VStack {
            AvatarGroupView()
            MovieGridScrollView(movies: props.movies)
        }
    }
}

// MARK: - State to props

extension MovieListView {
    func map(state: AppState, dispatch _: @escaping DispatchFunction) -> Props {
        return Props(movies: state.movies)
    }
}

// MARK: - Preview

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        StoreProvider(store: sampleStore) {
            MovieListView()
        }
    }
}
