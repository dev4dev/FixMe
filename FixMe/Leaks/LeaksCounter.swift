//
//  LeaksCounter.swift
//  FixMe
//
//  Created by Alex Antonyuk on 13.07.2023.
//

import Foundation

final class LeaksCounter {

    static let shared = LeaksCounter()

    private(set) var counter = 0

    private init() {}

    func up() {
        counter += 1
    }

    func down() {
        counter -= 1
    }
}
