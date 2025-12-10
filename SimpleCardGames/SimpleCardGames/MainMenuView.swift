//
//  MainMenuView.swift
//  SimpleCardGames
//
//  Created by Amarjit on 09/12/2025.
//

import SwiftUI

struct GameCard {
    let id: Int
    let title: String
    let route: Route
}

struct MainMenuView: View {
    @Environment(NavigationStack.self) var navigationStack

    let games: [GameCard] = [
        GameCard(id: 1, title: "Blackjack", route: .blackjackGame),
        GameCard(id: 2, title: "War", route: .warGame),
        GameCard(id: 3, title: "No Thanks", route: .noThanksGame),
        //GameCard(id: 4, title: "Spit", route: .spitGame),
        //GameCard(id: 5, title: "Go Fish", route: .goFishGame),
        //GameCard(id: 6, title: "Crazy Eights", route: .crazyEightsGame),
    ]

     let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.95, green: 0.93, blue: 0.88),
                    Color(red: 0.98, green: 0.96, blue: 0.91)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header
                VStack(spacing: 8) {
                    Text("Simple Card Games")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.black)
                    
                    Text("Choose a game to play")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 24)
                .padding(.horizontal, 16)
                .background(Color.white.opacity(0.6))
                
                // Games Grid
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(games, id: \.id) { game in
                            NavigationLink(value: game.route) {
                                GameCardView(title: game.title)
                            }
                        }
                    }
                    .padding(16)
                }
            }
        }
        .navigationDestination(for: Route.self) { route in
            switch route {
            case .mainMenu:
                MainMenuView()
            case .blackjackGame:
                BlackjackGameView()
            case .warGame:
                WarGameView()
            case .noThanksGame:
                Text("No Thanks Game (Coming Soon)")
            case .spitGame:
                Text("Spit Game (Coming Soon)")
            case .goFishGame:
                Text("Go Fish Game (Coming Soon)")
            case .crazyEightsGame:
                Text("Crazy Eights Game (Coming Soon)")
            case .settings:
                SettingsView()
            }
        }
    }
}


struct GameCardView: View {
    let title: String
    
    var body: some View {
        VStack(spacing: 12) {
            // Placeholder for game artwork
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color(red: 0.2, green: 0.4, blue: 0.7),
                                Color(red: 0.1, green: 0.3, blue: 0.6)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                
                VStack(spacing: 8) {
                    Image(systemName: "suit.spade.fill")
                        .font(.system(size: 32))
                        .foregroundColor(.white)
                    
                    Image(systemName: "suit.heart.fill")
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                }
            }
            .frame(height: 160)
            
            // Game Title
            Text(title)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.black)
                .lineLimit(2)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
    }
}

#Preview {
    MainMenuView()
}
