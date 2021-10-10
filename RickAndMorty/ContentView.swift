//
//  ContentView.swift
//  RickAndMorty
//
//  Created by Gerlandio Lucena on 26/09/21.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var model = CharacterModel()
    
    private let network = RequestCharacters()
    
    init() {
        refresh()
    }
    
    var body: some View {
        List(model.homeCharacters?.results ?? []) { character in
            Text(character.name ?? "Não disponível")
        }
    }
    
    func refresh() {
        network.request(to: \.homeCharacters, on: model)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
