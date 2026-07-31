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
        String(
            format: String(localized: "characters.count"),
            viewModel.characterList.count
        )
    }
    
    var body: some View {
        ZStack {
            Color("AppBackground")
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 24) {
                Header(title: String(localized: "common.characters"), secondoryText: characterCountText)
                    .padding(.horizontal, 24)
                    .padding(.top, 28)
                
                List {
                    ForEach(viewModel.characterList, id: \.id) { item in
                        Button {
                            viewModel.selectedCharacterId = item.id
                        } label: {
                            CharacterItem(character: item)
                                .task {
                                    await viewModel.loadNextPageIfNeeded(currentHero: item)
                                }
                        }
                        .buttonStyle(.plain)
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        .listRowInsets(
                            EdgeInsets(
                                top: 8,
                                leading: 24,
                                bottom: 8,
                                trailing: 24
                            )
                        )
                    }
                }
                .listStyle(.plain)
                .navigationDestination(item: $viewModel.selectedCharacterId) { id in
                    CharacterView(viewModel: CharacterViewModel(id: id))
                }
            }
            .onAppear {
                Task {
                    await viewModel.fetchInitialCharacters()
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
