//
//  CircularAvatarView.swift
//  Movie Night
//
//  Created by Zahan Malkani on 12/19/19.
//  Copyright © 2019 Wildlings. All rights reserved.
//

import SwiftUI
import CoreGraphics

struct CircularAvatarView: View {
    let person: String
    let diameter: CGFloat

    var body: some View {
        Image(person)
            .resizable()
            .clipShape(Circle())
            .overlay(
                Circle().stroke(Color.gray, lineWidth: 2))
            .frame(width: diameter, height: diameter)
    }
}

struct CircularAvatarView_Previews: PreviewProvider {
    static var previews: some View {
        CircularAvatarView(person: "Zahan", diameter: 100)
    }
}
