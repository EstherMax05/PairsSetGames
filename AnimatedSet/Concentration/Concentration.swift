//
//  Concentration.swift
//  Concentration
//
//  Created by Esther Max-Onakpoya on 6/13/19.
//  Copyright © 2019 Esther Max-Onakpoya. All rights reserved.
//

import Foundation

class Concentration {
    private(set) var cards = [ConcentrationCard]()
    
    private(set) var score = 50
    
    private var indexOfOneAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index: Int){
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // Check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                }
                else if cards[matchIndex].wasFlipped || cards[index].wasFlipped{
                    if cards[index].wasFlipped{
                        score -= 1
                    }
                    if cards[matchIndex].wasFlipped{
                        score -= 1
                    }
                }
                
                cards[matchIndex].wasFlipped = true
                cards[index].wasFlipped = true
                
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
                
            } else {
                //either no cards or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
           
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 0..<numberOfPairsOfCards {
            let card = ConcentrationCard()
            cards += [card, card]
        }
        cards.shuffle()
        
    }
}
