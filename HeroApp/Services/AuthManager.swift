//
//  AuthManager.swift
//  HeroApp
//
//  Created by User on 01.07.2026.
//

import SwiftUI
import Combine

class AuthManager: ObservableObject {
    @Published var isLoggedIn: Bool = false
    
    func login() {
        isLoggedIn = true
    }
    
    func logout() {
        isLoggedIn = false
    }
}
