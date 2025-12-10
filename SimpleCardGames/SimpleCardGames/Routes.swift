import Foundation
import SwiftUI
import PlayingCardKit

enum Route: Hashable {
    case mainMenu
    case blackjackGame
    case warGame
    case noThanksGame
    case settings
}

@ViewBuilder
func routeView(for route: Route) -> some View {
    switch route {
    case .mainMenu:
        MainMenuView()
    case .blackjackGame:
        BlackjackGameView()
    case .warGame:
        WarGameView()
    case .noThanksGame:
        Text("No Thanks Game (Coming Soon)")
    case .settings:
        SettingsView()
    }
}