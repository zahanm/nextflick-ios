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

    var body: some View {
        Image(person.image)
            .resizable()
            .scaledToFit()
            .clipShape(Circle())
    }
}

struct SingleAvatarView_Previews: PreviewProvider {
    static var previews: some View {
        let person = try! sampleStore.state.dbQueue.read { db in
            try Person.all().fetchOne(db)!
        }
        return SingleAvatarView(person: person)
    }
}
