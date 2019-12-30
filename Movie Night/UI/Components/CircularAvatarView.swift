//
//  CircularAvatarView.swift
//  Movie Night
//
//  Created by Zahan Malkani on 12/19/19.
//  Copyright © 2019 Wildlings. All rights reserved.
//

import CoreGraphics
import SwiftUI

struct CircularAvatarView: View {
    let person: Person
    let diameter: CGFloat

    var body: some View {
        Image(person.image)
            .resizable()
            .clipShape(Circle())
            .overlay(
                Circle().stroke(Color.gray, lineWidth: 2))
            .frame(width: diameter, height: diameter)
    }
}

struct CircularAvatarView_Previews: PreviewProvider {
    static var previews: some View {
        CircularAvatarView(person: Person("Zahan"), diameter: 100)
    }
}
