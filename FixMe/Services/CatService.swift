//
//  CatService.swift
//  FixMe
//
//  Created by Alex Antonyuk on 16.03.2025.
//

import Combine
import Foundation

final class CatService {
    func load() -> AnyPublisher<[Cat], any Error> {
        var request = URLRequest(url: .init(string: "https://api.thecatapi.com/v1/breeds")!)
        request.httpMethod = "GET"
        request.setValue("live_DVpUpncTxTzJhdWlTlwZ9y7ZeZIBteWUPAJESovCzGgS406Mv760l16FrXyfJWVY", forHTTPHeaderField: "x-api-key")

        return URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: [Cat].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
