//
//  SimpleCardGamesApp.swift
//  SimpleCardGames
//
//  Created by Amarjit on 09/12/2025.
//

import SwiftUI

@main
struct SimpleCardGamesApp: App {
    @State private var navigationStack = GameNavigationStack()
    
    var body: some Scene {
        WindowGroup {
            routeView(for: .mainMenu)
                .environment(navigationStack)
        }
    }
}