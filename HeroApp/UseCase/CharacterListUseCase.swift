//
//  CharacterListUseCase.swift
//  HeroApp
//
//  Created by User on 17.07.2026.
//

import Foundation

struct CharacterListUseCase {
    let networkService: NetworkService
    
    init(networkService: NetworkService? = nil) {
        self.networkService = networkService ?? NetworkService()
    }
    
    func execute() async throws -> [Character] {
        let response = try await networkService.request(urlString: URI.Character, methods: .GET)
        print(response)
        let list: CharacterListResponse = try networkService.decodeJSONData(response)
        return list.results
    }
}
