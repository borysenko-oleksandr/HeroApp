//
//  Characters.swift
//  HeroApp
//
//  Created by User on 08.07.2026.
//

import Foundation

struct Character: Decodable {
    let id: Int
    let name: String
    
}

struct CharacterDetails: Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let image: String
    let episode: [String]
    let url: String
    let created: String
    
}
