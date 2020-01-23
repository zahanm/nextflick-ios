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
        let d = CGFloat(100)
        let w = d * (1.0 - overlap)
        return
            HStack(spacing: 0) {
                ForEach(group.members) { person in
                    SingleAvatarView(person: person, diameter: d)
                        .frame(width: w)
                }
            }
            .padding([.horizontal], d * overlap / 2)
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
