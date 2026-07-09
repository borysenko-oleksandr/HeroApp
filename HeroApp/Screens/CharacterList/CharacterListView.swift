//
//  LoginView.swift
//  HeroApp
//
//  Created by User on 01.07.2026.
//

import SwiftUI
import Combine

struct CharacterListView: View {
    @EnvironmentObject var authManager: AuthManager
    @StateObject var viewModel = CharacterListViewModel()
    
    private var characterCountText: String {
        "\(viewModel.characterList?.count ?? 0) characters"
    }
    
    var body: some View {
        ZStack {
            Color("AppBackground")
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 24) {
                Header(title: "Characters", secondoryText: characterCountText)
                    .padding(.horizontal, 24)
                    .padding(.top, 28)
                
                List {
                    ForEach(viewModel.characterList ?? [], id: \.id) { item in
                        NavigationLink(value: item.id) {
                            CharacterItem(characterName: item.name)
                        }
                        .listRowBackground(Color.clear)
                    }
                }
                .listStyle(.plain)
                .navigationDestination(for: Int.self) { id in
                    CharacterView(id: id)
                }
            }
            .onAppear {
                Task {
                    await viewModel.fetchCharacters()
                }
            }
            .scrollContentBackground(.hidden)
        }
    }
}

#Preview {
    CharacterListView()
        .environmentObject(AuthManager())
}
