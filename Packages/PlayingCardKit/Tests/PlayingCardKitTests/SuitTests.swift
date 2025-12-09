//
//  SuitTests.swift
//  PlayingCardKit
//
//  Created by Amarjit on 09/12/2025.
//

import XCTest

@testable import PlayingCardKit

final class SuitTests: XCTestCase {
    func testSuitStringEquality() {
        XCTAssertEqual(Suit.spades.symbol, "♠")
        XCTAssertEqual(Suit.hearts.symbol, "♡")
        XCTAssertEqual(Suit.diamonds.symbol, "♢")
        XCTAssertEqual(Suit.clubs.symbol, "♣")
    }
    
    func testSuitComparable() {
        XCTAssertGreaterThan(Suit.spades, Suit.diamonds)
        XCTAssertGreaterThan(Suit.hearts, Suit.diamonds )
        XCTAssertGreaterThan(Suit.hearts, Suit.clubs)
        XCTAssertGreaterThan(Suit.diamonds, Suit.clubs)
    }
}
