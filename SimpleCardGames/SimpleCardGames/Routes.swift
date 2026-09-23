import Foundation
import SwiftUI
import PlayingCardKit

enum Route: Hashable {
    case mainMenu
    case blackjackGame
    case settings
}

@ViewBuilder
func routeView(for route: Route) -> some View {
    switch route {
    case .mainMenu:
        MainMenuView()
    case .blackjackGame:
        BlackjackGameView()    
    case .settings:
        SettingsView()
    }
}