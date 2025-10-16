//
//  DeckTests.swift
//  PlayingCardKit
//
//  Created by Amarjit on 10/05/2025.
//

import XCTest
@testable import PlayingCardKit

final class DeckTests: XCTestCase {
    func testCreate52CardDeck() {
        var countByPlayingCard: [PlayingCard: Int] = [:]
        
        var deck = Deck.standard52CardDeck()
        while let playingCard = deck.deal() {
            countByPlayingCard[playingCard, default: 0] += 1
        }
        
        XCTAssertEqual(countByPlayingCard.count, 52)
        XCTAssertTrue(countByPlayingCard.values.allSatisfy { $0 == 1 })
        
        for rank in Rank.allCases {
            for suit in Suit.allCases {
                let playingCard = PlayingCard(rank: rank, suit: suit)
                XCTAssertEqual(countByPlayingCard[playingCard], 1)
            }
        }
    }
    
    func testDeal() {
        let playingCard = PlayingCard(rank: .ace, suit: .clubs)
        var deck: Deck = [playingCard]
        
        XCTAssertEqual(deck.deal(), playingCard)
        XCTAssertNil(deck.deal())
    }
    
    func testCountEmptyDeckHasZeroCards() {
        let deck = Deck([])
        XCTAssertEqual(deck.count, 0)
    }
    
    func testCountStandard52CardDeckHas52Cards() {
        let deck = Deck.standard52CardDeck()
        
        XCTAssertEqual(deck.count, 52)
    }
    
    func testCountDealingDecreasesCountByOne() {
        var deck = Deck([PlayingCard(rank: .ace, suit: .spades), PlayingCard(rank: .queen, suit: .hearts)])
        
        XCTAssertEqual(deck.count, 2)
        XCTAssertNotNil(deck.deal())
        XCTAssertEqual(deck.count, 1)
    }
}
