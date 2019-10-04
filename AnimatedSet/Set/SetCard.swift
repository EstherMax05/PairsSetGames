//
//  Card.swift
//  SetGame
//
//  Created by Esther Max-Onakpoya on 6/25/19.
//  Copyright © 2019 Esther Max-Onakpoya. All rights reserved.
//

import Foundation
struct SetCard {
    var numberOfShapes: Int
    var color: CardColor
    var shape: Shape
    var texture: Texture
    var isFaceUp: Bool = false
    
    init(numberOfShapes: Int, color: CardColor, shape: Shape, texture: Texture){
        self.numberOfShapes = numberOfShapes
        self.color = color
        self.shape = shape
        self.texture = texture
    }
}
