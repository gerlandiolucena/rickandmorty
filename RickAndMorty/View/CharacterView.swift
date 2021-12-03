//
//  CharacterView.swift
//  RickAndMorty
//
//  Created by Gerlandio Lucena on 26/09/21.
//

import SwiftUI

struct CharacterView: View {
    
    var character: Character
    
    var body: some View {
        VStack {
            let placeHolder = Image(systemName: "person")
            let url = URL(string: character.image ?? "")!
            AsyncWebImageView(url: url, placeHolder: placeHolder)
            VStack {
                    Text(character.name ?? "")
                        .font(.system(size: 16, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .center)
                VStack {
                    HStack {
                        Circle()
                            .fill(character.status == .Alive ? Color.green : Color.red)
                            .frame(width: 10, height: 10, alignment: .center)
                        Text(character.location?.name ?? "Unknown")
                            .font(.system(size: 12))
                            .frame(alignment: .center)
                    }
                    HStack {
                        Circle()
                            .fill(Color.gray)
                            .frame(width: 10, height: 10, alignment: .center)
                            Text(character.species?.rawValue ?? "Unknown")
                            .font(.system(size: 12))
                            .frame(alignment: .center)
                    }
                }
            }
        }
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
        origin: Location(name: "Earth (Replacement Earth)",
                         url: "https://rickandmortyapi.com/api/location/1"
                       ),
        location: Location(name: "Earth (Replacement Earth)",
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
