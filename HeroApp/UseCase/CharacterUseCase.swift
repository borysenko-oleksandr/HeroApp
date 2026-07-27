//
//  CharacterUseCase.swift
//  HeroApp
//
//  Created by User on 17.07.2026.
//

import Foundation

struct CharacterUseCase {
    let networkService: NetworkService
    
    init(networkService: NetworkService? = nil) {
        self.networkService = networkService ?? NetworkService()
    }
    
    func excute(id: Int) async throws -> Character {
        let response = try await networkService.request(urlString: URI.Character, methods: .GET, params: "\(id)")
        let character: Character = try networkService.decodeJSONData(response)
        return character
    }
}
