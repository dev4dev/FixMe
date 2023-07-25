//
//  ReactiveView.swift
//  FixMe
//
//  Created by Alex Antonyuk on 25.07.2023.
//

import SwiftUI

struct ReactiveView: View {

    @ObservedObject private var viewModel = ReactiveViewModel()

    var body: some View {
        ZStack {
            List {
                ForEach(viewModel.cats) { cat in
                    Text(cat.name)
                }
            }

            Text("No cats on duty today!").opacity(viewModel.cats.isEmpty ? 1.0 : 0.0)
        }
        .navigationTitle("🚀🐈")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Load") {
                    viewModel.load()
                }
            }
        }
    }
}

struct ReactiveView_Previews: PreviewProvider {
    static var previews: some View {
        ReactiveView()
    }
}
