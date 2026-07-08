//
//  LoginView.swift
//  HeroApp
//
//  Created by User on 01.07.2026.
//

import SwiftUI

struct CharacterListView: View {
    @EnvironmentObject var authManager: AuthManager
    @StateObject var viewModel = CharacterListViewModel()
    
    var body: some View {
        VStack {
            List {
                ForEach(viewModel.characterList ?? [], id: \.id) { item in
                    NavigationLink(value: item.id) {
                        CharacterItem(characterName: item.name)
                    }
                }
            }
            .navigationDestination(for: Int.self) { id in
                CharacterView(id: id)
            }
        }.onAppear {
            Task {
                await viewModel.fetchCharacters()
            }
        }
    }
}

#Preview {
    CharacterListView()
}
