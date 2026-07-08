//
//  LoginView.swift
//  HeroApp
//
//  Created by User on 01.07.2026.
//

import SwiftUI

struct CharacterView: View {
    let id: Int
    @StateObject private var viewModel: CharacterViewModel
    
    init(id: Int) {
        self.id = id
        self._viewModel = StateObject(wrappedValue: CharacterViewModel(id: id))
    }

    var body: some View {
        VStack {
            
            if let character = viewModel.character {
                Text(character.name)
                Text(character.gender)
            } else {
                Text("Loading...")
            }
            
        }.onAppear {
            Task {
                await viewModel.fetchCharacters()
            }
        }
    }
}

#Preview {
    CharacterView(id: 1)
}
