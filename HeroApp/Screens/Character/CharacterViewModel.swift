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
    @Published var character: Character?
    
    init(id: Int, character: Character? = nil) {
        self.id = id
        self.character = character
    }
    
    let characterService = CharacterUseCase()
    
    
    func fetchCharacters() async {
        do {
            self.character = try await characterService.excute(id: id)
        } catch {
            print("Error fetchCharacters", error)
        }
    }
        
}
