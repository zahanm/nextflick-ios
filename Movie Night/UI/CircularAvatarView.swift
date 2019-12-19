//
//  CircularAvatarView.swift
//  Movie Night
//
//  Created by Zahan Malkani on 12/19/19.
//  Copyright © 2019 Wildlings. All rights reserved.
//

import SwiftUI

struct CircularAvatarView: View {
    let person: String

    var body: some View {
        Image(person)
            .clipShape(Circle())
            .overlay(
                Circle().stroke(Color.gray, lineWidth: 2))
    }
}

struct CircularAvatarView_Previews: PreviewProvider {
    static var previews: some View {
        CircularAvatarView(person: "Zahan")
    }
}
