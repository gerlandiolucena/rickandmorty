//
//  CustomOperators.swift
//  RickAndMorty
//
//  Created by Gerlandio Lucena on 02/10/21.
//

import Foundation

prefix operator <-

extension Data {
    static prefix func <-<T: Decodable>(data: Data) -> T? {
        return try? JSONDecoder().decode(T.self, from: data)
    }
}

