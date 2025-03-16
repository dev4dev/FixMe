//
//  Model.swift
//  FixMe
//
//  Created by Alex Antonyuk on 16.03.2025.
//

import Foundation
import Fakery

private let f = Faker()

@Observable
final class Model {
    struct Item: Identifiable {
        var id: UUID = .init()
        let name: String
        let date: Date = .init(timeIntervalSince1970: Double.random(in: 1700000000.0...1742150000.0))
        var favorite: Bool
    }

    var data: [Item] = []

    var favesCount: Int {
        data.count(where: { $0.favorite })
    }

    init(data: [Item] = []) {
        self.data = data
    }

    func add() {
        let item = Item(name: f.name.name(), favorite: Bool.random())
        data.append(item)
    }

    func delete(index: IndexSet) {
        data.remove(atOffsets: index)
    }
}
