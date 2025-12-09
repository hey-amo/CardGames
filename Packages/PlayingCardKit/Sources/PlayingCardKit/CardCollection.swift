//
//  CardCollection.swift
//  PlayingCardKit
//
//  Created by Amarjit on 10/05/2025.
//

public protocol CardCollection {
    associatedtype CardType: Equatable & Codable
    var cards: [CardType] { get }

    mutating func add(_ card: CardType)
    mutating func remove(_ card: CardType) -> Bool
    func contains(_ card: CardType) -> Bool
}
