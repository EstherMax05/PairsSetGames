//
//  View.swift
//  SetGame
//
//  Created by Esther Max-Onakpoya on 6/25/19.
//  Copyright © 2019 Esther Max-Onakpoya. All rights reserved.
//

import Foundation
import UIKit

enum Shape: String, CaseIterable {
    case oval = "▲"
    case diamond = "●"
    case squiggle = "■"
}

enum Texture: Int, CaseIterable {
    case striped
    case hollow
    case filled 
}

enum CardColor: CaseIterable {
    case red
    case green
    case purple
}

extension CardColor {
    var value: UIColor {
        get {
            switch self {
            case .red:
                return UIColor.red
            case .green:
                return UIColor.green
            case .purple:
                return UIColor.purple
            }
        }
    }
}
