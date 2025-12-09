//
//  CardImageTests.swift
//  PlayingCardKit
//
//  Created by Amarjit on 09/12/2025.
//

import XCTest
import UIKit
@testable import PlayingCardKit

final class CardImageTests: XCTestCase {
    func testTwoofClubsImageLoads() {

       let image = UIImage(
           named: "clubs-2",
           in: .module,
           compatibleWith: nil
       )

       XCTAssertNotNil(image, "Image should exist in Cards.xcassets")
    }
}
