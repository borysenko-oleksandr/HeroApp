//
//  ContentView.swift
//  HeroApp
//
//  Created by User on 01.07.2026.
//

import SwiftUI

struct MainView: View {
    @StateObject var authManager = AuthManager()
    
    var body: some View {
        if !authManager.isLoggedIn {
            NavigationStack {
                CharacterListView()
            }
            .environmentObject(authManager)
        } else {
            LoginView()
                .environmentObject(authManager)
        }
    }
}

#Preview {
    MainView()
}
