//
//  DiscardAndHandTests.swift
//  PlayingCardKit
//
//  Created by Amarjit on 09/12/2025.
//

import XCTest
@testable import PlayingCardKit

final class HandAndDiscardPileTests: XCTestCase {
    
    func testHandAddRemoveContains() {
        let card1 = Card(rank: .ace, suit: .spades)
        let card2 = Card(rank: .king, suit: .hearts)
        
        var hand = Hand<Card>()
        
        XCTAssertFalse(hand.contains(card1))
        
        hand.add(card1)
        XCTAssertTrue(hand.contains(card1))
        XCTAssertEqual(hand.cards.count, 1)
        
        hand.add(card2)
        XCTAssertEqual(hand.cards.count, 2)
        
        XCTAssertTrue(hand.remove(card1))
        XCTAssertFalse(hand.contains(card1))
        XCTAssertEqual(hand.cards.count, 1)
        
        let removedAll = hand.removeAll()
        XCTAssertEqual(removedAll.count, 1)
        XCTAssertEqual(hand.cards.count, 0)
    }
    
    func testDiscardPileBasic() {
        let card1 = Card(rank: .queen, suit: .diamonds)
        let card2 = Card(rank: .two, suit: .clubs)
        
        var pile = DiscardPile<Card>()
        
        pile.add(card1)
        XCTAssertEqual(pile.top, card1)
        XCTAssertTrue(pile.contains(card1))
        
        pile.add(card2)
        XCTAssertEqual(pile.top, card2)
        XCTAssertTrue(pile.contains(card2))
        
        XCTAssertTrue(pile.remove(card1))
        XCTAssertFalse(pile.contains(card1))
        
        let emptied = pile.empty()
        XCTAssertEqual(emptied.count, 1) // only card2 remains
        XCTAssertEqual(pile.cards.count, 0)
    }
}
