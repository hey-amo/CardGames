//
//  MainMenuView.swift
//  SimpleCardGames
//
//  Created by Amarjit on 09/12/2025.
//

import SwiftUI

import SwiftUI

struct GameCard {
    let id: Int
    let title: String
    let route: Route
}

struct NavigationHeaderView: View {
    var body: some View {
        // Navigation Title Bar
        HStack(spacing: 12) {
            // Left Button - Settings
            Button(action: {
                navigationStack.push(.settings)
            }) {
                Image(systemName: "gear")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.black)
                    .frame(width: 44, height: 44)
            }
            
            Spacer()
                                
            // Right Buttons
            HStack(spacing: 12) {
                // Gems Button
                Button(action: {
                    print("TBD: Gems shop")
                }) {
                    HStack(spacing: 6) {
                        Image(systemName: "diamond.fill")
                            .font(.system(size: 14, weight: .semibold))
                        Text("0")
                            .font(.system(size: 14, weight: .semibold))
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Color.purple)
                    .cornerRadius(8)
                }
                
                // Remove Ads Button
                Button(action: {
                    print("TBD: Remove ads")
                }) {
                    HStack(spacing: 6) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 14, weight: .semibold))
                        Text("Remove Ads")
                            .font(.system(size: 12, weight: .semibold))
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Color.blue)
                    .cornerRadius(8)
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.white.opacity(0.7))

        Divider()
            .background(Color.gray.opacity(0.2))
        }
    }
}

struct MainMenuView: View {
    @Environment(NavigationStack.self) var navigationStack
    
    let games: [GameCard] = [
        GameCard(id: 1, title: "Blackjack", route: .blackjackGame),
        GameCard(id: 2, title: "War", route: .warGame),
        GameCard(id: 3, title: "No Thanks", route: .noThanksGame),
    ]
    
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
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
                NavigationHeaderView()
                
                // Header Section
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
                .background(Color.white.opacity(0.4))
                
                // Games Grid
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(games, id: \.id) { game in
                            Button(action: {
                                navigationStack.push(game.route)
                            }) {
                                GameCardView(title: game.title)
                            }
                        }
                    }
                    .padding(16)
                }
            }
        }
    }
}

#Preview {
    MainMenuView()
        .environment(NavigationStack())
}