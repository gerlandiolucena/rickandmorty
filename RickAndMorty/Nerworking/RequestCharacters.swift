//
//  RequestCharacters.swift
//  RickAndMorty
//
//  Created by Gerlandio Lucena on 02/10/21.
//

import Foundation
import Combine

class RequestCharacters {
    private let urlString = "https://rickandmortyapi.com/api/character"
    private var publisher: AnyPublisher<HomeCharacters?, Error>?
    private var cancellable: Cancellable?
    
    init() {
        setupRequest()
    }
    
    private func setupRequest(page: Int = 1) {
        let urlQuery = URL(string: "\(urlString)?page=\(page)")!
        let request = URLRequest(url: urlQuery, timeoutInterval: 10.0)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        self.publisher = session.dataTaskPublisher(for: request)
            .handleEvents(receiveOutput: { print(NSString(data: $0.data, encoding: String.Encoding.utf8.rawValue)!) })
            .map {
                $0.data
            }
            .decode(type: HomeCharacters.self, decoder: JSONDecoder())
            .tryMap({ $0 })
            .eraseToAnyPublisher()
    }
    
    func request<Root>(to: ReferenceWritableKeyPath<Root, HomeCharacters?>, on: Root) {
        setupRequest()
        self.cancellable = publisher?.receive(on: DispatchQueue.main)
            .replaceError(with: HomeCharacters(info: Info(count: 0, pages: 0, next: "", prev: ""), results: []))
            .assign(to: to, on: on)
    }
    
    func loadNextPage<Root>(to: ReferenceWritableKeyPath<Root, [Character]?>, on: Root, page: Int) {
        setupRequest(page: page)
        self.cancellable = publisher?.receive(on: DispatchQueue.main)
            .replaceError(with: HomeCharacters(info: Info(count: 0, pages: 0, next: "", prev: ""), results: []))
            .map { $0?.results }
            .assign(to: to, on: on)
    }
}
