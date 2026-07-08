//
//  File.swift
//  HeroApp
//
//  Created by User on 08.07.2026.
//

import Foundation

struct CharacterService {
    let networkService = NetworkService()
    
    func getListOfCharacters() async throws -> [Character] {
        let response = try await networkService.request(urlString: URI.Character.rawValue, methods: .GET)
        let list: CharacterListResponse = try networkService.decodeJSONData(response)
        return list.results
    }
    
    func getCharacterBy(id: Int) async throws -> CharacterDetails {
        let response = try await networkService.request(urlString: URI.Character.rawValue + "/\(id)", methods: .GET)
        let character: CharacterDetails = try networkService.decodeJSONData(response)
        return character
    }
}

// MARK: Private
private struct CharacterListResponse: Decodable {
    let results: [Character]
}
