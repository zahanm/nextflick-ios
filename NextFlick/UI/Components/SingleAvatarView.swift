//
//  SingleAvatarView.swift
//  NextFlick
//
//  Created by Zahan Malkani on 12/19/19.
//  Copyright © 2019 Wildlings. All rights reserved.
//

import CoreGraphics
import SwiftUI

struct SingleAvatarView: View {
    let person: Person
    let diameter: CGFloat

    var body: some View {
        Image(person.image)
            .resizable()
            .clipShape(Circle())
            .frame(width: diameter, height: diameter)
    }
}

struct SingleAvatarView_Previews: PreviewProvider {
    static var previews: some View {
        SingleAvatarView(person: Person("Zahan"), diameter: 100)
    }
}
