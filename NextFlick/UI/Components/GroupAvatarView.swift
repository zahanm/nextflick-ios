//
//  GroupAvatarView.swift
//  NextFlick
//
//  Created by Zahan Malkani on 12/20/19.
//  Copyright © 2019 Wildlings. All rights reserved.
//

import CoreGraphics
import SwiftUI

struct GroupAvatarView: View {
    let overlap = CGFloat(0.2)
    let group: Group

    var body: some View {
        return GeometryReader { geometry in
            HStack(spacing: -geometry.size.width / 10) {
                ForEach(self.group.members) { person in
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
        GroupAvatarView(Group(TmdbAPI.mockPeople()))
    }
}
