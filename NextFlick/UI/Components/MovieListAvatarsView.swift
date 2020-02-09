//
//  GroupAvatarView.swift
//  NextFlick
//
//  Created by Zahan Malkani on 12/20/19.
//  Copyright © 2019 Wildlings. All rights reserved.
//

import CoreGraphics
import SwiftUI
import SwiftUIFlux

struct MovieListAvatarsView: ConnectedView {
    @EnvironmentObject var store: Store<AppState>
    let list: MovieList

    struct Props {
        let members: [Person]
        let fetchMembers: () -> Void
    }

    func body(props: Props) -> some View {
        return GeometryReader { geometry in
            HStack(spacing: -geometry.size.height * 0.2) {
                ForEach(props.members) { person in
                    SingleAvatarView(person: person)
                }
            }
            .onAppear {
                props.fetchMembers()
            }
        }
    }

    init(_ list: MovieList) {
        self.list = list
    }
}

// MARK: State to props

extension MovieListAvatarsView {
    func map(state: AppState, dispatch: @escaping DispatchFunction) -> Props {
        let members = state.movielistmembers[list.id!] ?? []
        return Props(members: members, fetchMembers: {
            dispatch(Actions.FetchListMembers(list: self.list))
        })
    }
}

#if DEBUG
    struct GroupSelectorView_Previews: PreviewProvider {
        static var previews: some View {
            let group = try! sampleStore.state.dbQueue.read { db in
                try MovieList.all().fetchOne(db)!
            }
            return StoreProvider(store: sampleStore) {
                MovieListAvatarsView(group)
                    .frame(height: 150)
            }
        }
    }
#endif
