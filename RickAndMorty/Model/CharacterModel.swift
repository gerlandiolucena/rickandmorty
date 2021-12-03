//
//  CharacterModel.swift
//  RickAndMorty
//
//  Created by Gerlandio Lucena on 03/10/21.
//

import Foundation

class CharacterModel: ObservableObject {
    @Published var homeCharacters: HomeCharacters? {
        didSet {
            isLoading = false
        }
    }
    @Published var isLoading = true
    var currentPage = 1
    
    var characters: [Character]? {
        didSet {
            guard let newResult = homeCharacters, let chars = characters else { return }
            var fullCharacters = newResult.results
            fullCharacters.append(contentsOf: chars)
            homeCharacters = HomeCharacters(info: newResult.info, results: fullCharacters)
        }
    }
}
