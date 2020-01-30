//
//  GroupToggle.swift
//  NextFlick
//
//  Created by Zahan Malkani on 1/29/20.
//  Copyright © 2020 Wildlings. All rights reserved.
//

import SwiftUI

struct GroupToggle: View {
    let group: Group
    @Binding var isInList: Bool

    var body: some View {
        Toggle(isOn: self.$isInList) {
            GroupAvatarView(group)
        }
    }
}

struct GroupToggle_Previews: PreviewProvider {
    static var previews: some View {
        GroupToggle(group: Group(TmdbAPI.mockPeople()), isInList: .constant(true))
    }
}
