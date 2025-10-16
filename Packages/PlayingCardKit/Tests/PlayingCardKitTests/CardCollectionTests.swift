//
//  CardCollectionTests.swift
//  PlayingCardKit
//
//  Created by Amarjit on 10/05/2025.
//

import XCTest
@testable import PlayingCardKit

/// for purposes of testing
private struct Hand: CardCollection {
    public var cards: [PlayingCard] = []
}
/// for purposes of testing
private struct DiscardPile: CardCollection {
    public var cards: [PlayingCard] = []
}

final class CardCollectionTests: XCTestCase {
    func testHandCanAddAndRemoveCards() {
        var hand = Hand()
        let aceOfSpades = PlayingCard(rank: .ace, suit: .spades)

        hand.add(aceOfSpades)
        XCTAssertTrue(hand.contains(aceOfSpades))

        let removed = hand.remove(aceOfSpades)
        XCTAssertTrue(removed)
        XCTAssertFalse(hand.contains(aceOfSpades))
    }
    
    func testDiscardPileBehavior() {
        var pile = DiscardPile()
        let queenOfHearts = PlayingCard(rank: .queen, suit: .hearts)

        pile.add(queenOfHearts)
        XCTAssertEqual(pile.cards.count, 1)

        _ = pile.remove(queenOfHearts)
        XCTAssertEqual(pile.cards.count, 0)
    }
}
