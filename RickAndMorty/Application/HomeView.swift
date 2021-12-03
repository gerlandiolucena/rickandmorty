//
//  ContentView.swift
//  RickAndMorty
//
//  Created by Gerlandio Lucena on 26/09/21.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var model = CharacterModel()
    
    private let network = RequestCharacters()
    
    init() {
        refresh()
    }
    
    var body: some View {
        NavigationView {
            if let results = model.homeCharacters?.results {
                CharacterList(results: results, isLoading: model.isLoading) {
                    self.loadNextPage()
                }
                .navigationBarTitle("Characters")
            }
        }
        .foregroundColor(.black)
    }
    
    func refresh() {
        network.request(to: \.homeCharacters, on: model)
    }
    
    func loadNextPage() {
        model.isLoading.toggle()
        model.currentPage += 1
        network.loadNextPage(to: \.characters, on: model, page: model.currentPage)
    }
}

struct CharacterList: View {
    var results: [Character]
    var isLoading: Bool
    let onLastItemAppeard: () -> Void
    
    var items: [GridItem] {
        Array(repeating: .init(.adaptive(minimum: 120)), count: 2)
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: items, spacing: 10) {
                ForEach(results, id: \.id) { character in
                    CharacterView(character: character).onAppear {
                        if character.id == results.last?.id {
                            self.onLastItemAppeard()
                        }
                    }
                }
            }
            if isLoading {
                loadingIndicator
            }
        }
    }
    
    private var loadingIndicator: some View {
        SpinnerLoading(style: .medium)
            .frame(idealWidth: .infinity, maxWidth: .infinity, alignment: .center)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
