//
//  GroupToggle.swift
//  NextFlick
//
//  Created by Zahan Malkani on 1/29/20.
//  Copyright © 2020 Wildlings. All rights reserved.
//

import SwiftUI
import SwiftUIFlux

struct GroupToggle: View {
    let group: GroupV2
    @Binding var isInList: Bool

    var body: some View {
        Toggle(isOn: self.$isInList) {
            GroupAvatarView(group)
        }
    }
}

struct GroupToggle_Previews: PreviewProvider {
    static var previews: some View {
        let group = try! sampleStore.state.dbQueue.read { db in
            try GroupV2.all().fetchOne(db)!
        }
        return StoreProvider(store: sampleStore) {
            GroupToggle(group: group, isInList: .constant(true))
        }
    }
}
