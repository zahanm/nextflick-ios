//
//  ContentView.swift
//  Movie Night
//
//  Created by Zahan Malkani on 12/1/19.
//  Copyright © 2019 Wildlings. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello, Zahan!")
                .font(.largeTitle)
                .foregroundColor(.blue)

            AvatarGroupView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
