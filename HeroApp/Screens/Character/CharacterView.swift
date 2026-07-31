//
//  LoginView.swift
//  HeroApp
//
//  Created by User on 01.07.2026.
//

import SwiftUI

struct CharacterView: View {
    @StateObject private var viewModel: CharacterViewModel

    init(viewModel: CharacterViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            
            if let character = viewModel.character {
                Text(character.name)
                Text(character.status ?? String(localized: "character.unknownStatus"))
            } else {
                Text(String(localized: "common.loading"))
            }
            
        }.onAppear {
            Task {
                await viewModel.fetchCharacters()
            }
        }
    }
}
