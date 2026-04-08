/**
No Thanks
A simple implementation of the No Thanks card game.
- 3 to 5 players
- The deck of cards is numbered from 3 to 35, with each card counting for a number of points equal to its face value. 
- Runs of two or more cards only count as the lowest value in the run
- Each player gets 11 chips at the start
*/

import Foundation

class NoThanksPlayer {
    var name: String
    var chips: Int
    var isAI: Bool = false
    private(set) var collectedCards: [Int]
    private(set) var score: Int = 0
    
    init(name: String, isAI: Bool = false) {
        self.name = name
        self.chips = 11
        self.collectedCards = []
        self.isAI = isAI
    }

    func calculateScore() {
        let sortedCards = collectedCards.sorted()
        var totalScore = 0
        var previousCard: Int? = nil
        
        for card in sortedCards {
            if let prev = previousCard, card == prev + 1 {
                // Part of a run, do not add score
            } else {
                totalScore += card
            }
            previousCard = card
        }
        
        self.score = totalScore - chips
    }
}

class NoThanksGame {
    private(set) var players: [NoThanksPlayer]
    private var deck: [Int]
    private var currentCard: Int?
    private var currentPlayerIndex: Int
    private var chipsOnCard: Int
    
    init(playerNames: [String]) {
        self.players = playerNames.map { NoThanksPlayer(name: $0) }
        self.deck = Array(3...35).shuffled()
        self.currentPlayerIndex = 0
        self.chipsOnCard = 0
        startNewRound()
    }
    
    private func startNewRound() {
        if let card = deck.popLast() {
            currentCard = card
            chipsOnCard = 0
        } else {
            endGame()
        }
    }
    
    func playerTakesCard() {
        guard let card = currentCard else { return }
        let player = players[currentPlayerIndex]
        player.collectCard(card: card, chips: chipsOnCard)
        advanceToNextPlayer()
        startNewRound()
    }
    
    func playerPasses() {
        let player = players[currentPlayerIndex]
        if player.chips > 0 {
            player.chips -= 1
            chipsOnCard += 1
            advanceToNextPlayer()
        }
    }
    
    private func advanceToNextPlayer() {
        currentPlayerIndex = (currentPlayerIndex + 1) % players.count
    }
    
    private func endGame() {
        // Calculate scores and determine winner
        for player in players {
            player.calculateScore()
        }
        // Game over logic here
    }
}