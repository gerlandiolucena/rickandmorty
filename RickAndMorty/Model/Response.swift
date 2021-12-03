//
//  Response.swift
//  RickAndMorty
//
//  Created by Gerlandio Lucena on 26/09/21.
//

import Foundation

// MARK: - Home
struct HomeCharacters: Decodable {
    let info: Info
    let results: [Character]
}

// MARK: - Info
struct Info: Decodable {
    let count, pages: Int?
    let next: String?
    let prev: String?
}

// MARK: - Result
struct Character: Decodable, Identifiable {
    let id: Int
    let name: String?
    let status: Status?
    let species: Species?
    let type: String?
    let gender: Gender?
    let origin, location: Location?
    let image: String?
    let episode: [String]?
    let url: String?
    let created: String?
}

enum Gender: String, Decodable {
    case Female
    case Male
    case Genderless
    case unknown
}

// MARK: - Location
struct Location: Decodable {
    let name: String
    let url: String
}

enum Species: String, Decodable {
    case Alien
    case Human
    case Humanoid
    case Poopybutthole
    case Mythological = "Mythological Creature"
    case Robot
    case Animal
    case Cronenberg
    case unknown
}

enum Status: String, Decodable {
    case Alive
    case Dead
    case unknown
}
