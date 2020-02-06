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

struct GroupAvatarView: View {
    @EnvironmentObject var store: Store<AppState>
    let group: Group

    var body: some View {
        let members = try! store.state.dbQueue.read { db in
            try self.group.members.fetchAll(db)
        }
        return GeometryReader { geometry in
            HStack(spacing: -geometry.size.height * 0.2) {
                ForEach(members) { person in
                    SingleAvatarView(person: person)
                }
            }
        }
    }

    init(_ group: Group) {
        self.group = group
    }
}

struct GroupSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        let group = try! sampleStore.state.dbQueue.read { db in
            try Group.all().fetchOne(db)!
        }
        return StoreProvider(store: sampleStore) {
            GroupAvatarView(group)
                .frame(height: 150)
        }
    }
}
