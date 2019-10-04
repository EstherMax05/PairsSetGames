//
//  ViewController.swift
//  Concentration
//
//  Created by Esther Max-Onakpoya on 6/12/19.
//  Copyright © 2019 Esther Max-Onakpoya. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {

    private lazy var game = Concentration(numberOfPairsOfCards: Int(floor(Double(cardButtons.count/2))))
    
    private(set) var flipCount: Int = initialFlipCount {
        // if flipCount changes change the label;
        didSet{
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    private var score: Int = intialScore {
        // if score changes change label;
        didSet{
            scoreLabel.text = "Score: \(score)"
        }
    }
    
   
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBOutlet private weak var scoreLabel: UILabel!
    
    // New Game
    @IBAction private func newGame(_ sender: UIButton) {
        game = Concentration(numberOfPairsOfCards: Int(floor(Double(cardButtons.count/2))))
        flipCount = initialFlipCount
        score = intialScore
        matchCardCount = 0
        winText.text = ""
        updateViewFromModel()
        emojiChoices = chosenTheme?.emojis ?? gameThemes["emojiTheme"]?.emojis
    }
    @IBOutlet weak var winText: UILabel!
    
    var chosenTheme: Theme? {
        didSet {
            emojiChoices = chosenTheme?.emojis ?? [""]
            emoji = [:]
            matchCardCount = 0
            
            updateViewFromModel()
            view.backgroundColor = chosenTheme?.backgroundColor ?? gameThemes["emojiTheme"]?.backgroundColor
            scoreLabel.textColor = chosenTheme?.labelColors ?? gameThemes["emojiTheme"]?.labelColors
            flipCountLabel.textColor = chosenTheme?.labelColors ?? gameThemes["emojiTheme"]?.labelColors
            for card in cardButtons {
                card.backgroundColor = chosenTheme?.cardFaceDownColor ?? gameThemes["emojiTheme"]?.labelColors
            }
            
        }
    }
    
    private lazy var emojiChoices = gameThemes["emojiTheme"]?.emojis
    
    @IBAction private func touchCard(_ sender: UIButton) {
        
        if let cardNumber = cardButtons.firstIndex(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            if !game.cards[cardNumber].isMatched{
                flipCount += 1
            }
            score = game.score
        }
        else{
            print("cardNumber is nil")
        }
    }
    private var matchCardCount = 0

    private func updateViewFromModel() {
        // Updating card buttons after flip
        if cardButtons != nil {
            
            for index in cardButtons.indices {
                
                let button = cardButtons[index]
                let card = game.cards[index]
                if card.isFaceUp {
                    button.setTitle(emoji(for:card), for: UIControl.State.normal)
                    button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    if card.isMatched {
                        button.setTitle(matchedColor, for: UIControl.State.normal)
                        button.backgroundColor = #colorLiteral(red: 0.6642242074, green: 0.6642400622, blue: 0.6642315388, alpha: 0.5046553938)
                        matchCardCount += 1
                    }
                    if matchCardCount == cardButtons.count {
                        // perform win animation later
                        winText.textColor = #colorLiteral(red: 0.2072014213, green: 0.8161401153, blue: 0.07722141594, alpha: 1)
                        
                        UIView.transition(with: view, duration: 0.6, options: [.transitionCrossDissolve, .allowUserInteraction], animations:{ self.winText.text = "YOU WIN!!!"}, completion: nil)
                        
                    }
                    
                } else if card.isMatched {
                        button.setTitle(matchedColor, for: UIControl.State.normal)
                        button.backgroundColor = #colorLiteral(red: 0.6642242074, green: 0.6642400622, blue: 0.6642315388, alpha: 0.5046553938)
                }
                else {
                    button.setTitle("", for: UIControl.State.normal)
                    if let color = chosenTheme?.cardFaceDownColor {
                        button.backgroundColor = color
                    } else {
                        button.backgroundColor =  gameThemes["emojiTheme"]?.backgroundColor
                    }
                }
            }
        }
    }
    
    var emoji = [Int:String]()
    
    private func emoji(for card: ConcentrationCard) -> String {
        if emoji[card.identifier] == nil, emojiChoices?.count ?? 0 > 0 { // emoji choices
            let randomIndex = Int.random(in: 0 ..< emojiChoices!.count)
            emoji[card.identifier] = emojiChoices!.remove(at: randomIndex)
        }
        
        return emoji[card.identifier] ?? "?"
    }
    
}

