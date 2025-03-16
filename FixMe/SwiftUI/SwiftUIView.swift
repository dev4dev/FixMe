//
//  SwiftUIView.swift
//  FixMe
//
//  Created by Alex Antonyuk on 13.07.2023.
//

import SwiftUI
struct SwiftUIView: View {

    @State var model = Model()

    init() {
    }

    var body: some View {
        TabView {
            DudesListView(model: model)
                .tabItem {
                    Label("Dudes", systemImage: "person.fill")
                }

            FavoriteDudesListView(model: model)
                .tabItem {
                    Label("Fave Dudes", systemImage: "person.crop.circle.fill.badge.checkmark")
                }
                .badge(model.favesCount)
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
