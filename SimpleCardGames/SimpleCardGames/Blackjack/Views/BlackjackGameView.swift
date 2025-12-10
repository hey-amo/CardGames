//
//  BlackjackGameView.swift
//  SimpleCardGames
//
//  Created by Amarjit on 09/12/2025.
//

import SwiftUI
import PlayingCardKit

struct BlackjackGameView: View {
    @State private var gameLogic = BlackjackGameLogic()
    @State private var resultMessage: String = "Place your bet to start"
    @State private var showResult: Bool = false

    var body: some View {
        ZStack {
            // Background
            LinearGradient(
                gradient: Gradient(colors: [Color(red: 0.1, green: 0.5, blue: 0.2), Color(red: 0.1, green: 0.35, blue: 0.15)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Header
                VStack {
                    Text("BLACKJACK")
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(.yellow)
                    
                    HStack {
                        VStack {
                            Text("Coins")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text("\(gameLogic.getPlayerCoins())")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.yellow)
                        }
                        
                        Spacer()
                        
                        if gameLogic.getCurrentBet() > 0 {
                            VStack {
                                Text("Current Bet")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                Text("\(gameLogic.getCurrentBet())")
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundColor(.green)
                            }
                        }
                    }
                    .padding()
                    .background(Color.black.opacity(0.3))
                    .cornerRadius(8)
                }
                .padding()
                .background(Color.green.opacity(0.7))
                .cornerRadius(12)
                
                // Game Area
                if gameLogic.getGameState() != .betting {
                    VStack(spacing: 20) {
                        // Dealer's Hand
                        VStack(alignment: .leading) {
                            Text("Dealer's Hand (\(gameLogic.getDealerHandValue()))")
                                .font(.headline)
                                .foregroundColor(.yellow)
                            
                            HStack(spacing: 8) {
                                ForEach(gameLogic.getDealerHand().cards, id: \.self) { card in
                                    CardView(card: card)
                                }
                                Spacer()
                            }
                        }
                        
                        Divider()
                            .background(Color.yellow.opacity(0.5))
                        
                        // Player's Hand
                        VStack(alignment: .leading) {
                            Text("Your Hand (\(gameLogic.getPlayerHandValue()))")
                                .font(.headline)
                                .foregroundColor(.yellow)
                            
                            HStack(spacing: 8) {
                                ForEach(gameLogic.getPlayerHand().cards, id: \.self) { card in
                                    CardView(card: card)
                                }
                                Spacer()
                            }
                        }
                    }
                    .padding()
                    .background(Color.green.opacity(0.6))
                    .cornerRadius(12)
                }
                
                // Message
                Text(resultMessage)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Spacer()
                
                // Action Buttons
                if gameLogic.getGameState() == .betting {
                    BettingButtonsView { amount in
                        if gameLogic.placeBet(amount) {
                            gameLogic.dealInitialCards()
                            resultMessage = "Hit or Stand?"
                        }
                    }
                } else if gameLogic.getGameState() == .playing {
                    HStack(spacing: 16) {
                        Button(action: {
                            gameLogic.playerHit()
                            if gameLogic.getPlayerHandValue() > 21 {
                                resultMessage = "Bust! You went over 21."
                                showGameResult()
                            } else if gameLogic.getPlayerHandValue() == 21 {
                                gameLogic.playerStand()
                                playDealerTurn()
                            }
                        }) {
                            Text("Hit")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        .disabled(!gameLogic.canPlayerHit())
                        
                        Button(action: {
                            gameLogic.playerStand()
                            playDealerTurn()
                        }) {
                            Text("Stand")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.orange)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                    .padding()
                } else if gameLogic.getGameState() == .gameOver {
                    Button(action: {
                        gameLogic.resetForNewRound()
                        resultMessage = "Place your bet to start"
                    }) {
                        Text("Play Again")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding()
                }
            }
            .padding()
        }
    }
    
    private func playDealerTurn() {
        gameLogic.dealerPlay()
        showGameResult()
    }
    
    private func showGameResult() {
        let result = gameLogic.evaluateGame()
        
        switch result {
        case .playerWin(let payout):
            resultMessage = "You win! +\(payout) coins"
        case .dealerWin:
            resultMessage = "Dealer wins."
        case .push:
            resultMessage = "Push! It's a tie."
        case .blackjack(let payout):
            resultMessage = "Blackjack! +\(payout) coins"
        case .bust:
            resultMessage = "Bust! Dealer wins."
        }
    }
} // :end BlackjackGameView

struct CardView: View {
    let card: Card
    
    var body: some View {
        VStack {
            Text("\(card.rank.symbol)")
                .font(.system(size: 20, weight: .bold))
            Text(card.suit.symbol)
                .font(.system(size: 24))
        }
        .frame(width: 60, height: 90)
        .background(Color.white)
        .border(Color.black, width: 2)
        .cornerRadius(4)
    }
}

struct BettingButtonsView: View {
    let onBet: (Int) -> Void
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 12) {
                ForEach([1, 2, 3, 5], id: \.self) { amount in
                    Button(action: { onBet(amount) }) {
                        Text("Bet \(amount)")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding(12)
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    BlackjackGameView()
}
