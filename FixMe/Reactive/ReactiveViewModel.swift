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

    private let refreshSubject: PassthroughSubject<Void, Never> = .init()
    @Published
    private(set) var cats: [Cat] = []

    init() {
        refreshSubject
            .flatMap { [unowned self] in
                self.request()
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

    func request() -> AnyPublisher<[Cat], any Error> {
        var request = URLRequest(url: .init(string: "https://api.thecatapi.com/v1/breeds")!)
        request.httpMethod = "GET"
        request.setValue("live_DVpUpncTxTzJhdWlTlwZ9y7ZeZIBteWUPAJESovCzGgS406Mv760l16FrXyfJWVY", forHTTPHeaderField: "x-api-key")

        return URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: [Cat].self, decoder: JSONDecoder())
            .delay(for: 3.0, scheduler: DispatchQueue.global())
            .eraseToAnyPublisher()
    }
}

//{
//    "weight": {
//        "imperial": "7  -  10",
//        "metric": "3 - 5"
//    },
//    "id": "abys",
//    "name": "Abyssinian",
//    "cfa_url": "http://cfa.org/Breeds/BreedsAB/Abyssinian.aspx",
//    "vetstreet_url": "http://www.vetstreet.com/cats/abyssinian",
//    "vcahospitals_url": "https://vcahospitals.com/know-your-pet/cat-breeds/abyssinian",
//    "temperament": "Active, Energetic, Independent, Intelligent, Gentle",
//    "origin": "Egypt",
//    "country_codes": "EG",
//    "country_code": "EG",
//    "description": "The Abyssinian is easy to care for, and a joy to have in your home. They’re affectionate cats and love both people and other animals.",
//    "life_span": "14 - 15",
//    "indoor": 0,
//    "lap": 1,
//    "alt_names": "",
//    "adaptability": 5,
//    "affection_level": 5,
//    "child_friendly": 3,
//    "dog_friendly": 4,
//    "energy_level": 5,
//    "grooming": 1,
//    "health_issues": 2,
//    "intelligence": 5,
//    "shedding_level": 2,
//    "social_needs": 5,
//    "stranger_friendly": 5,
//    "vocalisation": 1,
//    "experimental": 0,
//    "hairless": 0,
//    "natural": 1,
//    "rare": 0,
//    "rex": 0,
//    "suppressed_tail": 0,
//    "short_legs": 0,
//    "wikipedia_url": "https://en.wikipedia.org/wiki/Abyssinian_(cat)",
//    "hypoallergenic": 0,
//    "reference_image_id": "0XYvRd7oD",
//    "image": {
//        "id": "0XYvRd7oD",
//        "width": 1204,
//        "height": 1445,
//        "url": "https://cdn2.thecatapi.com/images/0XYvRd7oD.jpg"
//    }
//}

struct Cat: Decodable, Identifiable {
    let id: String
    let name: String
    let description: String
    let image: Image?

    struct Image: Decodable {
        let url: URL
    }
}
