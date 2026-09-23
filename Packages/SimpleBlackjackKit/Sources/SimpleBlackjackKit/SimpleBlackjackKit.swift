// Simple Blackjack
// Single player verses AI dealer only
// Dependency: PlayingCardKit package
// Aims: SOLID principles, protocol programming, functional programming

import PlayingCardKit

public enum BlackjackGameState {
    case betting, dealing, playing, dealerTurn, gameOver
}

public enum BlackjackResult {
    case playerWin(payout: Int)
    case dealerWin
    case push
    case blackjack(payout: Int)
    case bust
}

