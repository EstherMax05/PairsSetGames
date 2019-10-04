//
//  Card.swift
//  Concentration
//
//  Created by Esther Max-Onakpoya on 6/13/19.
//  Copyright © 2019 Esther Max-Onakpoya. All rights reserved.
//

import Foundation

struct ConcentrationCard {
    var isFaceUp = false
    var isMatched = false
    var wasFlipped = false
    var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
        
    }
    
    init() {
        self.identifier = ConcentrationCard.getUniqueIdentifier()
    }
}
