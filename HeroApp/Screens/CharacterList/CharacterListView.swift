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
    @State private var selectedCharacterId: Int?
    
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
                        Button {
                            selectedCharacterId = item.id
                        } label: {
                            CharacterItem(character: item)
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
                .navigationDestination(
                    isPresented: Binding(
                        get: { selectedCharacterId != nil },
                        set: { isPresented in
                            if !isPresented {
                                selectedCharacterId = nil
                            }
                        }
                    )
                ) {
                    if let selectedCharacterId {
                        CharacterView(viewModel: CharacterViewModel(id: selectedCharacterId))
                    }
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
