//
//  CharacterView.swift
//  RickAndMorty
//
//  Created by Gerlandio Lucena on 26/09/21.
//

import SwiftUI

struct CharacterView: View {
    
    var character: Character
    var imageLoader: AsyncImageLoader?
    
    init(character: Character) {
        self.character = character
        if let image = character.image {
            self.imageLoader = try? AsyncImageLoader(urlString: image)
        }
    }
    var body: some View {
        
    }
}

struct CharacterView_Previews: PreviewProvider {
    static var previews: some View {
        let char = Character(id: 1,
        name: "Rick Sanchez",
        status: Status.Alive,
        species: Species.Human,
        type: "",
        gender: Gender.Male,
        origin: Location(name: "Earth (C-137)",
                         url: "https://rickandmortyapi.com/api/location/1"
                       ),
        location: Location(name: "Earth (C-137)",
                           url: "https://rickandmortyapi.com/api/location/1"
                         ),
        image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
        episode: [
            "https://rickandmortyapi.com/api/episode/1",
            "https://rickandmortyapi.com/api/episode/2",
            "https://rickandmortyapi.com/api/episode/3",
            "https://rickandmortyapi.com/api/episode/4",
            "https://rickandmortyapi.com/api/episode/5"],
        url: "https://rickandmortyapi.com/api/character/1",
        created: "2017-11-04T18:48:46.250Z")
        
        CharacterView(character: char)
    }
}
