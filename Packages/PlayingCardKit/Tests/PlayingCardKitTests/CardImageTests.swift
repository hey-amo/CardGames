//
//  CardImageTests.swift
//  PlayingCardKit
//
//  Created by Amarjit on 09/12/2025.
//


import XCTest
@testable import PlayingCardKit
import UIKit

final class CardImageTests: XCTestCase {

    func testTwoofClubsImageLoads() {
        let image = UIImage(
            named: "clubs-2",
            in: .module,
            compatibleWith: nil
        )

        XCTAssertNotNil(image, "Image ace should exist in Cards.xcassets and be loadable.")
    }
}
