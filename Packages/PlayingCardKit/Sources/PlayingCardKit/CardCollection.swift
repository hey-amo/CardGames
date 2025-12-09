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
    associatedtype CardType: Equatable
    var cards: [CardType] { get set }

    mutating func add(_ card: CardType)
    mutating func remove(_ card: CardType) -> Bool
    func contains(_ card: CardType) -> Bool
}

public extension CardCollection {
    @inlinable
    mutating func add(_ card: CardType) {
        cards.append(card)
    }

    @discardableResult
    @inlinable
    mutating func remove(_ card: CardType) -> Bool {
        if let index = cards.firstIndex(of: card) {
            cards.remove(at: index)
            return true
        }
        return false
    }

    @inlinable
    func contains(_ card: CardType) -> Bool {
        cards.contains(card)
    }
}
