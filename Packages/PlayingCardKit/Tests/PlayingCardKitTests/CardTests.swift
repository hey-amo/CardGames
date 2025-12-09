//
//  CardTests.swift
//  PlayingCardKit
//
//  Created by Amarjit on 10/05/2025.
//

import XCTest
@testable import PlayingCardKit

final class CardTests: XCTestCase {
    func testCardSingle() {
        let card1 = Card(rank: .queen, suit: .diamonds)
        let card2 = Card(rank: .king, suit: .diamonds)
        let card3 = Card(rank: .ace, suit: .clubs)
        let card4 = Card(rank: .queen, suit: .diamonds)
        let card5 = Card(rank: .queen, suit: .clubs)
        
        XCTAssertGreaterThan(card2, card1)
        XCTAssertLessThan(card1, card2)
        XCTAssertGreaterThan(card3, card2)
        XCTAssertLessThan(card2, card3)
        XCTAssertEqual(card1, card4)
        XCTAssertGreaterThan(card4, card5)
        XCTAssertLessThan(card5, card4)
    }
    
    
    
    
}
