import SwiftUI
import PlayingCardKit

/**

- Setup: Deck split evenly between player and computer (26 cards each)
- Battle: Each player plays top card; highest rank wins all cards
- War: On tie, each player plays 3 face-down cards + 1 face-up card; winner takes all
- Card Values: Ace (14) > King (13) > Queen (12) > Jack (11) > 10-2
- Win Condition: First player to collect all 52 cards wins
- Score: Tracks cards won in each round


Features:
- Simple card visuals using rank symbols and suit emojis
- Real-time score tracking
- Game over detection
- Reset/play again functionality
- Clean UI with back navigation
*/

struct WarGameView: View {
    @StateObject private var gameLogic = WarGameLogic()
    @Environment(NavigationStack.self) var navigationStack
    
    var body: some View {
        ZStack {
            // Background
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.1, green: 0.4, blue: 0.2),
                    Color(red: 0.05, green: 0.25, blue: 0.15)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 24) {
                // Header with Back Button
                HStack {
                    Button(action: {
                        navigationStack.pop()
                    }) {
                        HStack(spacing: 8) {
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                        .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    Text("WAR")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.yellow)
                    
                    Spacer()
                    
                    // Placeholder for balance
                    Text("")
                        .frame(width: 50)
                }
                .padding()
                
                // Score Board
                HStack(spacing: 40) {
                    VStack(spacing: 8) {
                        Text("You")
                            .font(.headline)
                            .foregroundColor(.yellow)
                        Text("\(gameLogic.playerScore)")
                            .font(.system(size: 36, weight: .bold))
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue.opacity(0.6))
                    .cornerRadius(12)
                    
                    VStack(spacing: 8) {
                        Text("Computer")
                            .font(.headline)
                            .foregroundColor(.yellow)
                        Text("\(gameLogic.computerScore)")
                            .font(.system(size: 36, weight: .bold))
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red.opacity(0.6))
                    .cornerRadius(12)
                }
                .padding()
                
                Spacer()
                
                // Battle Area
                if !gameLogic.gameOver {
                    VStack(spacing: 32) {
                        // Player Card
                        VStack(spacing: 8) {
                            Text("Your Card")
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                            if let card = gameLogic.playerCard {
                                WarCardView(card: card)
                            } else {
                                WarCardPlaceholder()
                            }
                        }
                        
                        // VS
                        Text("VS")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.yellow)
                        
                        // Computer Card
                        VStack(spacing: 8) {
                            Text("Computer's Card")
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                            if let card = gameLogic.computerCard {
                                WarCardView(card: card)
                            } else {
                                WarCardPlaceholder()
                            }
                        }
                    }
                    .padding()
                    .background(Color.green.opacity(0.5))
                    .cornerRadius(12)
                }
                
                // Message
                Text(gameLogic.battleMessage)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .frame(height: 50)
                    .padding()
                    .background(Color.black.opacity(0.3))
                    .cornerRadius(8)
                
                Spacer()
                
                // Action Buttons
                if gameLogic.gameOver {
                    VStack(spacing: 16) {
                        Text(gameLogic.winner == "Player" ? "🎉 You Won! 🎉" : "💀 Game Over")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.yellow)
                        
                        Button(action: {
                            gameLogic.resetGame()
                        }) {
                            Text("Play Again")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding(14)
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                    .padding()
                    .background(Color.black.opacity(0.4))
                    .cornerRadius(12)
                } else {
                    Button(action: {
                        gameLogic.playRound()
                    }) {
                        Text("Play Round")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding(16)
                            .background(Color.yellow)
                            .foregroundColor(.black)
                            .cornerRadius(8)
                    }
                    .padding()
                }
            }
            .padding()
        }
    }
}

struct WarCardView: View {
    let card: Card
    
    var body: some View {
        VStack(spacing: 4) {
            Text(card.rank.symbol)
                .font(.system(size: 28, weight: .bold))
            Text(card.suit.symbol)
                .font(.system(size: 32))
        }
        .frame(width: 80, height: 120)
        .background(Color.white)
        .border(Color.black, width: 2)
        .cornerRadius(6)
    }
}

struct WarCardPlaceholder: View {
    var body: some View {
        VStack {
            Image(systemName: "questionmark")
                .font(.system(size: 28))
                .foregroundColor(.gray)
        }
        .frame(width: 80, height: 120)
        .background(Color.gray.opacity(0.3))
        .border(Color.gray, width: 2)
        .cornerRadius(6)
    }
}

#Preview {
    WarGameView()
        .environment(NavigationStack())
}