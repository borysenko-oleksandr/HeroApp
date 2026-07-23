//
//  ListItem.swift
//  HeroApp
//
//  Created by User on 08.07.2026.
//

import SwiftUI

struct CharacterItem: View {
    let character: Character
    
    private var subtitle: String {
        [character.status, character.species]
            .compactMap { $0 }
            .joined(separator: " · ")
    }
    
    private var statusColor: Color {
        switch character.status?.lowercased() {
        case "alive":
            return .green
        case "dead":
            return .red
        default:
            return .gray
        }
    }
    //Color(red: 0.08, green: 0.09, blue: 0.12)
    var body: some View {
        HStack(spacing: 20) {
            characterImage
            
            VStack(alignment: .leading, spacing: 10) {
                Text(character.name)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
                    .lineLimit(1)
                
                Text(subtitle)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.white.opacity(0.58))
                    .lineLimit(1)
                
                Text(character.location?.name ?? "Unknown location")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white.opacity(0.42))
                    .lineLimit(1)
            }
            
            Spacer(minLength: 12)
            
            Image(systemName: "chevron.right")
                .font(.system(size: 28, weight: .semibold))
                .foregroundColor(.white.opacity(0.32))
        }
        .padding(.horizontal, 22)
        .padding(.vertical, 20)
        .background(Color.gray.opacity(0.3))
        .overlay {
            RoundedRectangle(cornerRadius: 32)
                .stroke(Color.white.opacity(0.08), lineWidth: 2)
        }
        .clipShape(RoundedRectangle(cornerRadius: 32))
    }
    
    private var characterImage: some View {
        ZStack(alignment: .bottomTrailing) {
            AsyncImage(url: URL(string: character.image ?? "")) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Color.white.opacity(0.08)
            }
            .frame(width: 88, height: 88)
            .clipShape(RoundedRectangle(cornerRadius: 24))
            
            Circle()
                .fill(statusColor)
                .frame(width: 28, height: 28)
                .overlay {
                    Circle()
                        .stroke(Color(red: 0.08, green: 0.09, blue: 0.12), lineWidth: 5)
                }
                .offset(x: 8, y: 8)
        }
    }
}

#Preview {
    CharacterItem(
        character: Character(
            id: 1,
            name: "Rick Sanchez",
            status: "Alive",
            species: "Human",
            type: "",
            gender: "Male",
            location: CharacterLocation(
                name: "Citadel of Ricks",
                url: ""
            ),
            image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
            episode: nil,
            url: nil
        )
    )
    .padding()
}
