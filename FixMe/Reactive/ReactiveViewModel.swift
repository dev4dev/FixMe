//
//  ReactiveViewModel.swift
//  FixMe
//
//  Created by Alex Antonyuk on 25.07.2023.
//

import Foundation
import Combine

final class ReactiveViewModel: ObservableObject {
    private var subscriptions: Set<AnyCancellable> = .init()
    let service = CatService()

    private let refreshSubject: PassthroughSubject<Void, Never> = .init()
    @Published
    private(set) var cats: [Cat] = []

    init() {
        refreshSubject
            .flatMap { [unowned self] in
                self.service.load()
                    .delay(for: 3.0, scheduler: DispatchQueue.global())
            }
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] cats in
                print("Loaded: \(cats.count) cats")
                self?.cats = cats
            }
            .store(in: &subscriptions)
    }

    func load() {
        refreshSubject.send()
    }
}
