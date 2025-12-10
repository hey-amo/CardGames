//
//  MainMenuView.swift
//  SimpleCardGames
//
//  Created by Amarjit on 09/12/2025.
//

import SwiftUI

struct MainMenuView: View {
    var body: some View {
        VStack {
            Text("Simple card games")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Button("Blackjack") {
                // launch Blackjack game
            }
        }
        .padding()
    }
}

#Preview {
    MainMenuView()
}
