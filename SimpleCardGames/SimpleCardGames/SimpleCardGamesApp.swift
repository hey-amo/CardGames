//
//  SimpleCardGamesApp.swift
//  SimpleCardGames
//
//  Created by Amarjit on 09/12/2025.
//

import SwiftUI

@main
struct SimpleCardGamesApp: App {
    @State private var navigationStack = NavigationStack()

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $navigationStack.path) {
                MainMenuView()
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                        case .mainMenu:
                            MainMenuView()
                        case .blackjackGame:
                            BlackjackGameView()
                        }
                    }
            }
            .environment(navigationStack)
        }
    }
}
