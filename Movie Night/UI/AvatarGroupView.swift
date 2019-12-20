//
//  GroupSelectorView.swift
//  Movie Night
//
//  Created by Zahan Malkani on 12/20/19.
//  Copyright © 2019 Wildlings. All rights reserved.
//

import SwiftUI
import CoreGraphics

struct AvatarGroupView: View {
    let overlap = CGFloat(0.4)

    var body: some View {
        let d = CGFloat(100)
        let w = d * (1.0 - overlap)
        return
            HStack(spacing: 0) {
                CircularAvatarView(person: "Zahan", diameter: d)
                    .frame(width: w)
                CircularAvatarView(person: "Vibha", diameter: d)
                    .frame(width: w)
                CircularAvatarView(person: "Ollie", diameter: d)
                    .frame(width: w)
            }
            .padding([.horizontal], d * overlap / 2)

    }
}

struct GroupSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarGroupView()
    }
}
