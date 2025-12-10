// BJGame.swift

import Foundation
import PlayingCardKit

enum BlackjackGameState {
    case betting, dealing, playing, dealerTurn, gameOver
}

enum BlackjackResult {
    case playerWin(payout: Int)
    case dealerWin
    case push
    case blackjack(payout: Int)
    case bust
}

class BlackjackGameLogic {
    private var deck: Deck
    private var playerHand: Hand
    private var dealerHand: Hand
    private var gameState: BlackjackGameState = .betting
    private var currentBet: Int = 0
    private var playerCoins: Int

    init(playerCoins: Int = 100) {
        self.playerCoins = playerCoins
        self.deck = Deck()
        self.playerHand = Hand()
        self.dealerHand = Hand()
        shuffleDeck()
    }

    // MARK: - Game setup
    private func shuffleDeck() {
        deck = Deck()
    }

    func placeBet(_ amount: Int) -> Bool {
        guard amount > 0 && amount <= playerCoins else { return false }
        currentBet = amount
        playerCoins -= amount
        gameState = .dealing
        return true
    }

    func dealInitialCards() {
        playerHand = Hand()
        dealerHand = Hand()
        
        // Deal 2 cards to player and dealer alternately
        playerHand.add(card: deck.draw()!)
        dealerHand.add(card: deck.draw()!)
        playerHand.add(card: deck.draw()!)
        dealerHand.add(card: deck.draw()!)
        
        gameState = .playing
        
        // Check for immediate blackjack
        if calculateHandValue(playerHand) == 21 {
            gameState = .gameOver
        }
    }

    // MARK: - Player Actions
    func playerHit() -> Bool {
        guard gameState == .playing else { return false }
        guard let card = deck.draw() else { return false }
        
        playerHand.add(card: card)
        
        let playerValue = calculateHandValue(playerHand)
        if playerValue > 21 {
            gameState = .gameOver
        } else if playerValue == 21 {
            gameState = .dealerTurn
        }
        
        return true
    }
    
    func playerStand() {
        guard gameState == .playing else { return }
        gameState = .dealerTurn
    }
    
    // MARK: - Dealer AI
    func dealerPlay() {
        var dealerValue = calculateHandValue(dealerHand)
        
        // Dealer must hit on 16 or less, stand on 17 or more
        while dealerValue < 17 {
            guard let card = deck.draw() else { break }
            dealerHand.add(card: card)
            dealerValue = calculateHandValue(dealerHand)
        }
        
        gameState = .gameOver
    }
    
    // MARK: - Hand Evaluation
    func evaluateGame() -> BlackjackResult {
        let playerValue = calculateHandValue(playerHand)
        let dealerValue = calculateHandValue(dealerHand)
        
        // Player busted
        if playerValue > 21 {
            return .bust
        }
        
        // Dealer busted
        if dealerValue > 21 {
            let payout = currentBet * 2
            playerCoins += payout
            return .playerWin(payout: payout)
        }
        
        // Check for blackjack (21 with 2 cards)
        if playerValue == 21 && playerHand.cards.count == 2 {
            let payout = Int(Double(currentBet) * 1.5)
            playerCoins += payout
            return .blackjack(payout: payout)
        }
        
        // Compare values
        if playerValue > dealerValue {
            let payout = currentBet * 2
            playerCoins += payout
            return .playerWin(payout: payout)
        } else if playerValue == dealerValue {
            playerCoins += currentBet // Return bet
            return .push
        } else {
            return .dealerWin
        }
    }
    
    // MARK: - Hand Value Calculation
    private func calculateHandValue(_ hand: Hand) -> Int {
        var value = 0
        var aces = 0
        
        for card in hand.cards {
            value += cardValue(card)
            if card.rank == .ace {
                aces += 1
            }
        }
        
        // Adjust for aces (treat as 1 instead of 11 if busting)
        while value > 21 && aces > 0 {
            value -= 10
            aces -= 1
        }
        
        return value
    }
    
    private func cardValue(_ card: Card) -> Int {
        switch card.rank {
        case .ace:
            return 11
        case .jack, .queen, .king:
            return 10
        default:
            return card.rank.rawValue
        }
    }
    
    // MARK: - Getters
    func getPlayerHand() -> Hand { playerHand }
    func getDealerHand() -> Hand { dealerHand }
    func getGameState() -> BlackjackGameState { gameState }
    func getPlayerCoins() -> Int { playerCoins }
    func getCurrentBet() -> Int { currentBet }
    func getPlayerHandValue() -> Int { calculateHandValue(playerHand) }
    func getDealerHandValue() -> Int { calculateHandValue(dealerHand) }
    
    func canPlayerHit() -> Bool {
        gameState == .playing && getPlayerHandValue() < 21
    }
    
    func resetForNewRound() {
        currentBet = 0
        gameState = .betting
    }
}

