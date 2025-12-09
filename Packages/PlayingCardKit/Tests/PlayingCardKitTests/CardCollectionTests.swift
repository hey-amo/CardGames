//
//  CardCollectionTests.swift
//  PlayingCardKit
//
//  Created by Amarjit on 09/12/2025.
//

import XCTest

@testable import PlayingCardKit

final class CardCollectionTests: XCTestCase {
    /// for purposes of testing
    private struct Hand: CardCollection {
        public var cards: [Card] = []
    }
    /// for purposes of testing
    private struct DiscardPile: CardCollection {
        public var cards: [Card] = []
    }
    
    final class CardCollectionTests: XCTestCase {
        func testHandCanAddAndRemoveCards() {
            var hand = Hand()
            let aceOfSpades = Card(rank: .ace, suit: .spades)
            
            hand.add(aceOfSpades)
            XCTAssertTrue(hand.contains(aceOfSpades))
            
            let removed = hand.remove(aceOfSpades)
            XCTAssertTrue(removed)
            XCTAssertFalse(hand.contains(aceOfSpades))
        }
        
        func testDiscardPileBehavior() {
            var pile = DiscardPile()
            let queenOfHearts = Card(rank: .queen, suit: .hearts)
            
            pile.add(queenOfHearts)
            XCTAssertEqual(pile.cards.count, 1)
            
            _ = pile.remove(queenOfHearts)
            XCTAssertEqual(pile.cards.count, 0)
        }
    }
    
}
