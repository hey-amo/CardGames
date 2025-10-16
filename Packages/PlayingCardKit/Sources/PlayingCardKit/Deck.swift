//
//  Deck.swift
//  PlayingCardKit
//
//  Created by Amarjit on 10/05/2025.
//

import Foundation

/// Model for creating a deck of playing cards
/// 52 cards, 4 suits: clubs, diamonds, spades, clubs, 13 ranks: 2-10, jack, queen, king, ace

public struct Deck: Equatable, Codable {
    fileprivate var cards: [PlayingCard]

    /// Returns a deck of 52 playing cards.
    public static func standard52CardDeck() -> Deck {
        var cards: [PlayingCard] = []
        for rank in Rank.allCases {
            for suit in Suit.allCases {
                cards.append(PlayingCard(rank: rank, suit: suit))
            }
        }

        return Deck(cards)
    }

    public init(_ cards: [PlayingCard]) {
        self.cards = cards
    }
    
    public mutating func shuffle() {
        cards.shuffle()
    }

    /// Deals a card from the deck.
    ///
    /// Return last card in the deck.
    public mutating func deal() -> PlayingCard? {
        guard !cards.isEmpty else { return nil }

        return cards.removeLast()
    }
    
    /// Number of cards remaining in the deck.
    public var count: Int {
        cards.count
    }
}

// MARK: - ExpressibleByArrayLiteral

extension Deck : ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: PlayingCard...) {
        self.init(elements)
    }
}
