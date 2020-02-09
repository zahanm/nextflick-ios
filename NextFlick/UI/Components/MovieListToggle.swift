//
//  GroupToggle.swift
//  NextFlick
//
//  Created by Zahan Malkani on 1/29/20.
//  Copyright © 2020 Wildlings. All rights reserved.
//

import SwiftUI
import SwiftUIFlux

struct MovieListToggle: View {
    let group: MovieList
    var isInList: Binding<Bool>

    var body: some View {
        HStack {
            MovieListAvatarsView(group)
            Spacer()
            Toggle("", isOn: self.isInList)
        }
    }
}

// MARK: Preview

#if DEBUG
    struct GroupToggle_Previews: PreviewProvider {
        static var previews: some View {
            let group = try! sampleStore.state.dbQueue.read { db in
                try MovieList.all().fetchOne(db)!
            }
            return StoreProvider(store: sampleStore) {
                MovieListToggle(group: group, isInList: .constant(true))
            }
        }
    }
#endif
