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
    
    func execute(page: String? = nil) async throws -> ExecutResult {
        let queryParams: [(name: String, value: String)] = [(name: "page", value: page ?? "1")]
        
        let response = try await networkService.request(
            urlString: URI.Character,
            methods: .GET,
            queryParams: queryParams
        )
        let list: CharacterListResponse = try networkService.decodeJSONData(response)
        return ExecutResult(result: list.results, hasMore: list.info.next != nil)
    }
    
}
