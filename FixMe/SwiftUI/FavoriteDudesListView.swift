//
//  FavoriteDudesListView.swift
//  FixMe
//
//  Created by Alex Antonyuk on 16.03.2025.
//

import SwiftUI

struct FavoriteDudesListView: View {
    @Bindable var model: Model

    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Favorite People")
        }
    }

    @ViewBuilder
    private var content: some View {
        if model.data.filter(\.favorite).isEmpty {
            ContentUnavailableView {
                Label("No Favorite Dudes!", systemImage: "person.badge.plus")
            } description: {
                Text("You can manage your favorite dudes here!")
            }
        } else {
            list
        }
    }

    private var list: some View {
        List {
            ForEach($model.data.filter { $0.favorite.wrappedValue }) { $item in
                HStack {
                    Text(item.name)

                    Spacer()

                    Button {
                        item.favorite.toggle()
                    } label: {
                        Image(systemName: item.favorite ? "star.fill" : "star")
                    }
                }
                .padding()
            }
            .onDelete { index in
                model.delete(index: index)
            }
        }
    }
}

#Preview {
    FavoriteDudesListView(model: .init())
}
