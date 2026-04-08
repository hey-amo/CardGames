import Foundation
import PlayingCardKit

enum WarGameState {
    case playing
    case battle
    case war
    case gameOver(winner: String)
}

enum BattleResult {
    case playerWins
    case computerWins
    case tie
}
import PlayingCardKit

extension Rank {
    var numericValue: Int {
        switch self {
        case .ace:
            return 14
        case .king:
            return 13
        case .queen:
            return 12
        case .jack:
            return 11
        case .ten:
            return 10
        case .nine:
            return 9
        case .eight:
            return 8
        case .seven:
            return 7
        case .six:
            return 6
        case .five:
            return 5
        case .four:
            return 4
        case .three:
            return 3
        case .two:
            return 2
        }
    }
    
    var symbol: String {
        switch self {
        case .ace:
            return "A"
        case .king:
            return "K"
        case .queen:
            return "Q"
        case .jack:
            return "J"
        case .ten:
            return "10"
        case .nine:
            return "9"
        case .eight:
            return "8"
        case .seven:
            return "7"
        case .six:
            return "6"
        case .five:
            return "5"
        case .four:
            return "4"
        case .three:
            return "3"
        case .two:
            return "2"
        }
    }
}

class WarGameLogic: ObservableObject {
    @Published var gameState: WarGameState = .playing
    @Published var playerScore: Int = 0
    @Published var computerScore: Int = 0
    @Published var playerCard: Card?
    @Published var computerCard: Card?
    @Published var battleMessage: String = "Tap to start battle"
    @Published var gameOver: Bool = false
    @Published var winner: String = ""
    
    private var playerDeck: [Card] = []
    private var computerDeck: [Card] = []
    private var battlePile: [Card] = []
    private var computerBattlePile: [Card] = []
    
    init() {
        setupGame()
    }
    
    // MARK: - Game Setup
    private func setupGame() {
        let fullDeck = createAndShuffleDeck()
        playerDeck = Array(fullDeck.prefix(26))
        computerDeck = Array(fullDeck.suffix(26))
        gameState = .playing
        battleMessage = "Tap to play"
    }
    
    private func createAndShuffleDeck() -> [Card] {
        var deck: [Card] = []
        for suit in Suit.allCases {
            for rank in Rank.allCases {
                deck.append(Card(suit: suit, rank: rank))
            }
        }
        return deck.shuffled()
    }
    
    // MARK: - Game Logic
    func playRound() {
        // Check if either player is out of cards
        if playerDeck.isEmpty {
            endGame(winner: "Computer")
            return
        }
        
        if computerDeck.isEmpty {
            endGame(winner: "Player")
            return
        }
        
        // Draw cards for battle
        let playerCard = playerDeck.removeFirst()
        let computerCard = computerDeck.removeFirst()
        
        self.playerCard = playerCard
        self.computerCard = computerCard
        battlePile.append(playerCard)
        computerBattlePile.append(computerCard)
        
        // Determine battle result
        let result = determineBattle(playerCard: playerCard, computerCard: computerCard)
        
        switch result {
        case .playerWins:
            gameState = .battle
            battleMessage = "You win this round!"
            playerWinsBattle()
            
        case .computerWins:
            gameState = .battle
            battleMessage = "Computer wins this round!"
            computerWinsBattle()
            
        case .tie:
            gameState = .war
            battleMessage = "War! Draw 3 cards face down..."
            playWar()
        }
    }
    
    private func determineBattle(playerCard: Card, computerCard: Card) -> BattleResult {
        let playerValue = playerCard.rank.numericValue
        let computerValue = computerCard.rank.numericValue
        
        if playerValue > computerValue {
            return .playerWins
        } else if computerValue > playerValue {
            return .computerWins
        } else {
            return .tie
        }
    }
    
    private func playerWinsBattle() {
        playerScore += battlePile.count + computerBattlePile.count
        playerDeck.append(contentsOf: battlePile)
        playerDeck.append(contentsOf: computerBattlePile)
        resetBattle()
    }
    
    private func computerWinsBattle() {
        computerScore += battlePile.count + computerBattlePile.count
        computerDeck.append(contentsOf: battlePile)
        computerDeck.append(contentsOf: computerBattlePile)
        resetBattle()
    }
    
    private func playWar() {
        // Each player puts 3 cards face down, then 1 card face up
        var playerWarCards: [Card] = []
        var computerWarCards: [Card] = []
        
        // Draw 3 cards face down
        for _ in 0..<3 {
            if !playerDeck.isEmpty {
                playerWarCards.append(playerDeck.removeFirst())
            }
            if !computerDeck.isEmpty {
                computerWarCards.append(computerDeck.removeFirst())
            }
        }
        
        // Draw the battle card
        if playerDeck.isEmpty || computerDeck.isEmpty {
            endGame(winner: playerDeck.isEmpty ? "Computer" : "Player")
            return
        }
        
        let playerBattleCard = playerDeck.removeFirst()
        let computerBattleCard = computerDeck.removeFirst()
        
        playerCard = playerBattleCard
        computerCard = computerBattleCard
        
        battlePile.append(contentsOf: playerWarCards)
        battlePile.append(playerBattleCard)
        computerBattlePile.append(contentsOf: computerWarCards)
        computerBattlePile.append(computerBattleCard)
        
        // Determine war result
        let result = determineBattle(playerCard: playerBattleCard, computerCard: computerBattleCard)
        
        switch result {
        case .playerWins:
            gameState = .battle
            battleMessage = "You win the war!"
            playerWinsBattle()
            
        case .computerWins:
            gameState = .battle
            battleMessage = "Computer wins the war!"
            computerWinsBattle()
            
        case .tie:
            battleMessage = "Another war!"
            playWar()
        }
    }
    
    private func resetBattle() {
        battlePile.removeAll()
        computerBattlePile.removeAll()
        gameState = .playing
    }
    
    private func endGame(winner: String) {
        gameOver = true
        self.winner = winner
        gameState = .gameOver(winner: winner)
        battleMessage = "\(winner) wins the game!"
    }
    
    func resetGame() {
        playerScore = 0
        computerScore = 0
        playerCard = nil
        computerCard = nil
        battleMessage = "Tap to play"
        gameOver = false
        setupGame()
    }
}