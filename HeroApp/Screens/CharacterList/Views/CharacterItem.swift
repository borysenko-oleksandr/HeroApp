//
//  ListItem.swift
//  HeroApp
//
//  Created by User on 08.07.2026.
//

import SwiftUI

struct CharacterItem: View {
    var characterName: String
    
    var body: some View {
        Text(characterName)
            .foregroundColor(.white)
    }
}

#Preview {
    CharacterItem(characterName: "Richard")
}
