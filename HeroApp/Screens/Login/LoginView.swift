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
        Button(String(localized: "common.login")) {
            authManager.login()
        }
    }
}

#Preview {
    LoginView()
}
