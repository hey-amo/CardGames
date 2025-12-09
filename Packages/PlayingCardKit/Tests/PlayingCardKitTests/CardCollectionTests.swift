//
//  CardCollectionTests.swift
//  PlayingCardKit
//
//  Created by Amarjit on 09/12/2025.
//

import XCTest

@testable import PlayingCardKit

final class CardCollectionTests: XCTestCase {
   
    func testHandCanAddAndRemoveCards() {
        var hand: Hand<Card> = Hand()
        let aceOfSpades = Card(rank: .ace, suit: .spades)
        
        hand.add(aceOfSpades)
        XCTAssertTrue(hand.contains(aceOfSpades))
        
        let removed = hand.remove(aceOfSpades)
        XCTAssertTrue(removed)
        XCTAssertFalse(hand.contains(aceOfSpades))
    }
}
