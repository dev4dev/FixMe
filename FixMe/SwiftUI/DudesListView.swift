//
//  DudesListView.swift
//  FixMe
//
//  Created by Alex Antonyuk on 16.03.2025.
//

import SwiftUI

struct DudesListView: View {
    @Bindable var model: Model

    var body: some View {
        NavigationStack {
            content
                .navigationTitle("People")
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        Button {
                            model.add()
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
        }
    }

    @ViewBuilder
    private var content: some View {
        if model.data.isEmpty {
            ContentUnavailableView {
                Label("No Dudes!", systemImage: "person.badge.plus")
            } description: {
                Text("You can manage your dudes here!")
            } actions: {
                Button("Add Dude!") {
                    model.add()
                }
            }
        } else {
            list
        }
    }

    private var list: some View {
        List {
            ForEach($model.data) { $item in
                HStack {
                    VStack(alignment: .leading) {
                        Text(item.name)
                            .font(.headline)
                        Text(item.date.formatted(.dateTime.day().month().year()))
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }

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

struct DudesListView_Previews: PreviewProvider {
    static var previews: some View {
        DudesListView(model: .init())
    }
}
