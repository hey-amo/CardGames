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
                routeView(for: .mainMenu)
                    .navigationDestination(for: Route.self) { route in
                        routeView(for: route)
                    }
            }
            .environment(navigationStack)
        }
    }
}