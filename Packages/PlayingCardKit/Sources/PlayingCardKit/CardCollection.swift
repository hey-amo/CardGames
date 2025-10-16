//
//  CardCollection.swift
//  PlayingCardKit
//
//  Created by Amarjit on 10/05/2025.
//

/// A protocol that allows flexible types: hand, pile, discard stack, etc.
/// A generic interface for any collection of playing cards (e.g. hand, pile, discard stack),
/// providing basic add/remove/contains operations.

public protocol CardCollection {
    var cards: [PlayingCard] { get set }

    mutating func add(_ card: PlayingCard)
    mutating func remove(_ card: PlayingCard) -> Bool
    func contains(_ card: PlayingCard) -> Bool
}

public extension CardCollection {
    mutating func add(_ card: PlayingCard) {
        cards.append(card)
    }

    mutating func remove(_ card: PlayingCard) -> Bool {
        if let index = cards.firstIndex(of: card) {
            cards.remove(at: index)
            return true
        }
        return false
    }

    func contains(_ card: PlayingCard) -> Bool {
        cards.contains(card)
    }
}
