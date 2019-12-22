//
//  PosterGridScrollView.swift
//  Movie Night
//
//  Created by Zahan Malkani on 12/22/19.
//  Copyright © 2019 Wildlings. All rights reserved.
//

import SwiftUI

struct PosterGridScrollView: View {
    let posters = [
        Poster(id: 0, imageName: "joker"),
        Poster(id: 1, imageName: "favourite"),
        Poster(id: 2, imageName: "ford-v-ferrari"),
        Poster(id: 3, imageName: "green-book"),
        Poster(id: 4, imageName: "favourite"),
        Poster(id: 5, imageName: "joker"),
        Poster(id: 6, imageName: "green-book"),
    ]

    var body: some View {
        var grouped: [(Poster, Poster?)] = []
        for i in stride(from: 0, to: posters.count, by: 2) {
            var second: Poster?
            if i + 1 < posters.count {
                second = posters[i + 1]
            } else {
                second = nil
            }
            grouped.append((posters[i], second))
        }

        return List {
            ForEach(grouped, id: \.0.id) { row in
                HStack(spacing: 0) {
                    Image(row.0.imageName)
                        .resizable()
                        .scaledToFit()
                        .border(Color.gray)
                    if row.1 != nil {
                        Image(row.1!.imageName)
                            .resizable()
                            .scaledToFit()
                            .border(Color.gray)
                    } else {
                        Spacer()
                            .scaledToFit()
                    }
                }.listRowInsets(EdgeInsets())
            }
        }
    }
}

struct Poster : Identifiable {
    let id : Int
    let imageName : String
}

struct PosterGridScrollView_Previews: PreviewProvider {
    static var previews: some View {
        PosterGridScrollView()
    }
}
