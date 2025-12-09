//
//  CardAssetProvider.swift
//  PlayingCardKit
//
//  Created by Amarjit on 09/12/2025.
//

import Foundation
import UIKit

public protocol CardAssetProvider {
    func image(for card: Card) -> UIImage
}
