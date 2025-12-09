//
//  Hand.swift
//  PlayingCardKit
//
//  Created by Amarjit on 09/12/2025.
//

import Foundation

/// A collection representing a player's hand of cards.
public struct Hand<CardType: Equatable & Codable>: CardCollection, Codable {
    private var _cards: [CardType] = []

    public var cards: [CardType] {
        get { _cards }
        set { _cards = newValue }
    }
    
    public init(cards: [CardType] = []) {
        self.cards = cards
    }
    
    public mutating func add(_ card: CardType) {
        self._cards.append(card)
    }
    
    @discardableResult
    public mutating func remove(_ card: CardType) -> Bool {
        if let i = cards.firstIndex(of: card) {
            cards.remove(at: i)
            return true
        }
        return false
    }
    
    public func contains(_ card: CardType) -> Bool {
        return cards.contains(card)
    }
    
    /// Removes all cards and returns them as an array.
    @inlinable
    public mutating func removeAll() -> [CardType] {
        let removed = cards
        cards.removeAll()
        return removed
    }
}
