//
//  RequestCharacters.swift
//  RickAndMorty
//
//  Created by Gerlandio Lucena on 02/10/21.
//

import Foundation
import Combine

class RequestCharacters {
    private let url = URL(string: "https://rickandmortyapi.com/api/character")!
    
    private let publisher: AnyPublisher<HomeCharacters?, Error>
    private var cancellable: Cancellable?
    
    init() {
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 10.0)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        self.publisher = session.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: HomeCharacters.self, decoder: JSONDecoder())
            .tryMap({ $0 })
            .eraseToAnyPublisher()
    }
    
    func request<Root>(to: ReferenceWritableKeyPath<Root, HomeCharacters?>, on: Root) {
        self.cancellable = publisher.receive(on: DispatchQueue.main)
            .replaceError(with: HomeCharacters(info: Info(count: 0, pages: 0, next: "", prev: ""), results: []))
            .assign(to: to, on: on)
    }
}
