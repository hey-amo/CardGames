//
//  PlayingCard.swift
//  PlayingCardKit
//
//  Created by Amarjit on 10/05/2025.
//

/// A playing card has a rank and a suit, and can be compared to another playing card.
public struct PlayingCard: Equatable, Hashable, Codable {
    public let rank: Rank
    public let suit: Suit
}

// MARK: Identifiable

extension PlayingCard: Identifiable {
    public var id: String { "\(rank.rawValue)_of_\(suit.rawValue)" }
}

// MARK: Comparable

extension PlayingCard: Comparable {
    /// Whether the left playing card is less than the right playing card.
    public static func <(lhs: PlayingCard, rhs: PlayingCard) -> Bool {
        return lhs.rank == rhs.rank ? lhs.suit < rhs.suit : lhs.rank < rhs.rank
    }

    /// Whether the left playing card is greater than the right playing card.
    public static func >(lhs: PlayingCard, rhs: PlayingCard) -> Bool {
        return lhs.rank == rhs.rank ? lhs.suit > rhs.suit : lhs.rank > rhs.rank
    }
}

// MARK: - CustomStringConvertible

extension PlayingCard: CustomStringConvertible {
    public var description: String {
        return "\(suit) \(rank)"
    }
}
