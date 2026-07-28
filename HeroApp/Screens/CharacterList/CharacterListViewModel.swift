//
//  LoginViewModel.swift
//  HeroApp
//
//  Created by User on 01.07.2026.
//

import Foundation
import SwiftUI
import Combine

@MainActor
final class CharacterListViewModel: ObservableObject {
    @EnvironmentObject var authManager: AuthManager
    @Published var selectedCharacterId: Int?
    @Published var characterList: [Character] = []
    
    @Published var isLoading: Bool = false
    @Published var hasMore: Bool = true
    
    let characterService = CharacterListUseCase()
    
    private var page = 1
    private var paginationTriggerIds: Set<Int> = []
    
    func fetchInitialCharacters() async {
        guard characterList.isEmpty else { return }
        await fetchCharacters()
    }
    
    func loadNextPageIfNeeded(currentHero: Character) async {
        guard let lastHero = characterList.last,
              lastHero.id == currentHero.id,
              !paginationTriggerIds.contains(currentHero.id),
              !isLoading,
              hasMore else { return }
        
        paginationTriggerIds.insert(currentHero.id)
        page += 1
        
        await fetchCharacters()
    }
    
    private func fetchCharacters() async {
        guard !isLoading, hasMore else { return }
        
        isLoading = true

        defer {
            isLoading = false
        }

        do {
            print(page)
            let data = try await characterService.execute(page: "\(page)")
            
            self.characterList.append(contentsOf: data.result)
            self.hasMore = data.hasMore
            
        } catch {
            print("Error fetchCharacters", error)
            if page > 1 {
                page -= 1
            }
            if let lastHeroId = characterList.last?.id {
                paginationTriggerIds.remove(lastHeroId)
            }
        }
    }

}
