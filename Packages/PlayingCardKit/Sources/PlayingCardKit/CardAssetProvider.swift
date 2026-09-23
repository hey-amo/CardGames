//
//  CardAssetProvider.swift
//  PlayingCardKit
//
//  Created by Amarjit on 09/12/2025.
//

import Foundation

#if canImport(UIKit)
import UIKit
public typealias CardImage = UIImage
#elseif canImport(AppKit)
import AppKit
public typealias CardImage = NSImage
#endif

public protocol CardAssetProvider {
    func image(for card: Card) -> CardImage
}
