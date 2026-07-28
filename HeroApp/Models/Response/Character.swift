//
//  Character.swift
//  HeroApp
//
//  Created by User on 17.07.2026.
//

import Foundation

struct CharacterListResponse: Decodable {
    let info: CharacterListInfo
    let results: [Character]
}

struct CharacterListInfo: Decodable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

struct ExecutResult {
    let result: [Character]
    let hasMore: Bool
}
