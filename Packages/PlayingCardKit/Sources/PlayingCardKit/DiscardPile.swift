//
//  DiscardPile.swift
//  PlayingCardKit
//
//  Created by Amarjit on 09/12/2025.
//

import Foundation

public struct DiscardPile<CardType: Equatable & Codable>: CardCollection, Codable {
    
    private var _cards: [CardType] = []
    
    public var cards: [CardType] {
        get { _cards }
        set { _cards = newValue }
    }
    
    public init(cards: [CardType] = []) {
        self.cards = cards
    }
        
    public mutating func add(_ card: CardType) {
        _cards.append(card)
    }
    
    @discardableResult
    public mutating func remove(_ card: CardType) -> Bool {
        if let index = cards.firstIndex(of: card) {
            _cards.remove(at: index)
            return true
        }
        return false
    }
    
    public func contains(_ card: CardType) -> Bool {
        _cards.contains(card)
    }
    
    @inlinable
    public mutating func empty() -> [CardType] {
        let removed = cards
        cards.removeAll()
        return removed
    }
    
    @inlinable
    public var top: CardType? {
        cards.last
    }
}

