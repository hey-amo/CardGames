import XCTest
import PlayingCardKit
@testable import SimpleBlackjackKit

final class SimpleBlackJackTests: XCTestCase {
    func testBlackjackCanUsePlayingCardKit() {
        var deck = Deck.standard52CardDeck()

        XCTAssertEqual(deck.count, 52)
        XCTAssertNotNil(deck.deal())
        XCTAssertEqual(deck.count, 51)
    }
}
