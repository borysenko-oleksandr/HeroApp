//
//  LoginView.swift
//  HeroApp
//
//  Created by User on 01.07.2026.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authManager: AuthManager
    
    var body: some View {
        Button("Login") {
            authManager.login()
        }
    }
}

#Preview {
    LoginView()
}
