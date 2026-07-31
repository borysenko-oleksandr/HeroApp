//
//  Header.swift
//  HeroApp
//
//  Created by User on 09.07.2026.
//

import SwiftUI

struct Header: View {
    var title: String
    var secondoryText: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 14) {
                Circle()
                    .fill(Color("AccentGreen"))
                    .frame(width: 14, height: 14)
                    .shadow(color: Color("AccentGreen").opacity(0.7), radius: 10)
                
                Text(String(localized: "character.index"))
                    .font(.system(size: 14, weight: .bold))
                    .tracking(6)
                    .foregroundStyle(Color("SecondaryText"))
            }
            
            Text(title)
                .font(.system(size: 44, weight: .bold))
                .foregroundStyle(.white)
            
            Text(secondoryText)
                .font(.system(size: 20, weight: .medium))
                .foregroundStyle(Color("SecondaryText"))
        }
    }
}

#Preview {
    Header(title: "Characters", secondoryText: "Text")
}
