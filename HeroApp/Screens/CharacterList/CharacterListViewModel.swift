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
class CharacterListViewModel: ObservableObject {
    @Published var characterList: [Character]?
    
    let characterService = CharacterService()
    
    
    func fetchCharacters() async {
        do {
            self.characterList = try await characterService.getListOfCharacters()
        } catch {
            print("Error fetchCharacters")
        }
    }
        
}
