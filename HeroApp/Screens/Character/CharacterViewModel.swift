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
class CharacterViewModel: ObservableObject {
    let id: Int
    @Published var character: CharacterDetails?
    
    init(id: Int, character: CharacterDetails? = nil) {
        self.id = id
        self.character = character
    }
    
    let characterService = CharacterService()
    
    
    func fetchCharacters() async {
        do {
            self.character = try await characterService.getCharacterBy(id: id)
        } catch {
            print("Error fetchCharacters")
        }
    }
        
}
