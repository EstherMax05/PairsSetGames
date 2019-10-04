//
//  Set.swift
//  SetGame
//
//  Created by Esther Max-Onakpoya on 6/25/19.
//  Copyright © 2019 Esther Max-Onakpoya. All rights reserved.
//

import Foundation

class SetGame {
    
    let numberOfInitalVisibleCards = 12
    
    private(set) var deckPosition = 0
    
    private(set) var deck = [SetCard]()
    
    var selectedCards = [SetCard]()
    
    private var matchedCards = [SetCard]()
    
    private(set) var visibleCards = [SetCard]()
    
    private(set) var score = 500
    
    private var numberOfSelectedCards: Int =  0
    
    func selectCards(including card: SetCard) {
        selectedCards.append(card)
    }
    
    func checkSet(for cards: [SetCard], at indices: [Int]) -> Bool {
        var answer = false
        // Check if numberOfSelectedCards == 3 in the VC
        var textureCheckSet = Set<Texture>()
        var colorCheckSet = Set<CardColor>()
        var numberCheckSet = Set<Int>()
        var shapeCheckSet = Set<Shape>()
        //for the selected cards
        if cards.count == 3 {
            for card in cards{
                textureCheckSet.insert(card.texture)
                colorCheckSet.insert(card.color)
                numberCheckSet.insert(card.numberOfShapes)
                shapeCheckSet.insert(card.shape)
            }
            if textureCheckSet.count != 2 && colorCheckSet.count != 2 && numberCheckSet.count != 2 && shapeCheckSet.count != 2 {// if the number of same elements are one or three then theres all diff or all same shape
                matchedCards += cards //Check that matched cards is truly increasing
                // remove cards from deck once displayed
                score += 5
                for index in indices.sorted().reversed(){
                    visibleCards.remove(at: index)
                }
                answer = true
            } else {
                score -= 3
            }
            selectedCards = []
        }
        return answer
    }
    
    func dealThree(given maximumNumberOfVisibleCards: Int) {
        if visibleCards.count <= maximumNumberOfVisibleCards && deck.count - deckPosition >= 3 {
            visibleCards += deck[deckPosition..<deckPosition+3]
            deckPosition = deckPosition+3
        }
    }
    
    func deselectCards(at index: Int) {
        selectedCards.remove(at: index)
    }
    
    func reshuffleVisibleCards() {
        visibleCards.shuffle()
    }
    
    init() {
        
        for number in 1...3 {
            for color in CardColor.allCases {
                for shape in Shape.allCases {
                    for texture in Texture.allCases {
                        let card = SetCard(numberOfShapes: number, color: color, shape: shape, texture: texture)
                        deck.append(card)
                    }
                }
            }
        }
        deck.shuffle()
        visibleCards += deck[0..<numberOfInitalVisibleCards]
        deckPosition = numberOfInitalVisibleCards
    }
}
