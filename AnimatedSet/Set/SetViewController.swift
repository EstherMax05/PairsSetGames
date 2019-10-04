//
//  ViewController.swift
//  GraphicalSetGame
//
//  Created by Esther Max-Onakpoya on 7/3/19.
//  Copyright © 2019 Esther Max-Onakpoya. All rights reserved.
//

import UIKit

class SetViewController: UIViewController {

    private(set) lazy var game = SetGame()
    
    var answer = false{
        didSet {
            // function that responds to answer
        }
    }
    
    var gameIndex = 0 {
        didSet {
            cardButtons = []
            cardButtonsTaps = []
        }
    }
    
    var resetButtonTapsIndex = 0
    
    var selectedCards = [SetCard]() {
        didSet {
            if selectedCards.count == 3  {
                answer = game.checkSet(for: selectedCards, at: selectedIndices)
                updateUI(basedOn: answer)
                // print("is this possible")
            }
        }
    }
    
    private(set) var cardButtons: [UIButton] = []
    
    private var cardButtonsTaps: [Int] = []
    
    var selectedIndices = [Int]()
    
    func updateUI(basedOn answer: Bool){
        scoreLabel.text = "Score: " + String(game.score)
        if answer{
            // cardButtons = []
            // cardButtonsTaps = []
            dealThreeAction()
        }
        
    }
    
    
    var isDealThreeButtonVisible = true {
        didSet {
            dealThreeButton.setTitle("", for: .normal)
        }
    }
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var dealThreeButton: UIButton!
    
    @IBAction func deal3Button(_ sender: UIButton) {
        undoSelections()
        dealThreeAction()
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        undoSelections()
        gameIndex += 1
        game = SetGame()
        
        graphicalSetView.setCards = Array(game.deck[0..<graphicalSetView.numberOfCardsDisplayed])
        // print(" graphicalSetCardView.setCards: ",  graphicalSetView.setCards)
        scoreLabel.text = "newgame: " + String(game.score)
        dealThreeButton.setTitle("Deal 3", for: .normal)
        // print("Number of buttons:", graphicalSetView.cardButtons.count)
//        print("deckPost", game.deckPosition, game.deck.count)
        addButtons()
        
        graphicalSetView.viewIndex = 0
    }
    
    @IBOutlet weak var graphicalSetView: GraphicalSetCardView!
    
    @IBAction func clearSelection(_ sender: UIButton) {
        
        scoreLabel.text = "Score: " + String(game.score)
        undoSelections()
        
//        let button = UIButton(frame: CGRect(x: 50, y: 50, width: 150, height: 60))
//        button.backgroundColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
//        button.setTitle("Tap me", for: .normal)
//        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
//        self.view.addSubview(button)
        // addButtonAction(to: graphicalSetView.cardButtons)
    }
    
    @IBAction func deal3Swipe(_ sender: UISwipeGestureRecognizer) {
        
        if sender.state == .ended {
            // scoreLabel.text = "Swiped: " + String(game.score)
            // deal 3 cards here'
            undoSelections()
            dealThreeAction()
            
        }
        
        
    }
    
    @IBAction func rotationShuffle(_ sender: UIRotationGestureRecognizer) {
        guard sender.view != nil else { return }
        
        if sender.state == .ended {
            // scoreLabel.text = "rotated: " + String(game.score)
            // reshuffle cards here
            ReshuffleToContinue.text = ""
            game.reshuffleVisibleCards()
            undoSelections()
            cardButtonsTaps = []
            cardButtons = []
            addButtons()
            graphicalSetView.setCards = game.visibleCards
            
        }
        /*if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            gestureRecognizer.view?.transform = gestureRecognizer.view!.transform.rotated(by: gestureRecognizer.rotation)
            gestureRecognizer.rotation = 0
        }*/
    }
    
    @IBOutlet weak var ReshuffleToContinue: UILabel!
    private func undoSelections(){
        while cardButtonsTaps.reduce(0,+) != 0 {
            let currentIndex = cardButtonsTaps.lastIndex(of: 1)!
            graphicalSetView.deselectCardButton(with: cardButtons[currentIndex])
            cardButtonsTaps[currentIndex] = 0
        }
    }
    
    private func dealThreeAction(){
        game.dealThree(given: 81)
        // graphicalSetView.setCards = Array(game.visibleCards)
        // addButtonAction(to: graphicalSetView.cardButtons)
//        print("deal3")
        if game.deckPosition == game.deck.count {
            isDealThreeButtonVisible = false
        }
        
        cardButtons = []
        cardButtonsTaps = []
        graphicalSetView.setCards = game.visibleCards
//        print("graphicalSetView.setCards.count:", graphicalSetView.setCards.count, game.visibleCards.count)
        
        graphicalSetView.viewIndex += 1
        
        addButtons()
        
    }
    
//    override func viewDidLayoutSubviews() {
//
//        addButtons()
//    }
//
    func addButtons(as normal: Bool = true) {
        graphicalSetView.grid.cellCount = game.visibleCards.count
//        print("is it gettin in if so show:", graphicalSetView.grid.cellCount)
        // graphicalSetView.layoutIfNeeded()
        var localGrid = Grid(layout: .aspectRatio(graphicalSetView.grid.aspectRatio))
        if normal {
            localGrid = graphicalSetView.grid
        } else {
            let localGridSize = CGSize(width: graphicalSetView.grid.frame.height, height: graphicalSetView.grid.frame.width)
            localGrid.frame = CGRect(origin: graphicalSetView.grid.frame.origin, size: localGridSize)
        }
        localGrid.cellCount = game.visibleCards.count
        for cell in localGrid.cellFrames {
            let newCell = cell.insetBy(dx: cell.width*0.08, dy: cell.height*0.05)
            let button = UIButton(frame: newCell)
            button.setTitle("", for: .normal)
            button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            graphicalSetView.addSubview(button)

            cardButtons.append(button)
            cardButtonsTaps.append(0)
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = "Score: " + String(game.score)
        graphicalSetView.setCards = Array(game.deck[0..<graphicalSetView.numberOfCardsDisplayed])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addButtons()
        
    }
    
    var trans = false
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        undoSelections()
        game.reshuffleVisibleCards()
         graphicalSetView.setCards = game.visibleCards
        ReshuffleToContinue.text = "Reshuffle To Continue"
        cardButtons = []
        cardButtonsTaps = []
        if trans {
            cardButtons = []
            cardButtonsTaps = []
            addButtons()
            trans = false
        }
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        graphicalSetView.setNeedsLayout()
        graphicalSetView.setNeedsDisplay()
        graphicalSetView.layoutIfNeeded()
        if trans {
            cardButtons = []
            cardButtonsTaps = []
            addButtons()
            trans = false
        }
    }
    
    @objc func buttonAction(sender: UIButton) {
        //graphicalSetView.selectCardButton(with: sender)
        // print("Button tapped")
        if let indexOfButton = cardButtons.firstIndex(of: sender) {
            if cardButtonsTaps[indexOfButton] == 0 {
                cardButtonsTaps[indexOfButton] = 1
                graphicalSetView.selectCardButton(with: cardButtons[indexOfButton])
            }
            else {
                cardButtonsTaps[indexOfButton] = 0
                graphicalSetView.deselectCardButton(with: cardButtons[indexOfButton])
            }
            
            if cardButtonsTaps.reduce(0,+) == 3 {
                resetButtonTapsIndex = 0
                // reset buttonTaps to all be in untapped state
                while resetButtonTapsIndex < 3 {
                    let currentIndex = cardButtonsTaps.lastIndex(of: 1)!
                    cardButtonsTaps[currentIndex] = 0
                    graphicalSetView.deselectCardButton(with: cardButtons[currentIndex])
                    selectedIndices.append(currentIndex)
                    selectedCards.append(graphicalSetView.setCards[currentIndex])
                    resetButtonTapsIndex += 1
//                    print("reset", resetButtonTapsIndex)
                }
                selectedIndices = []
                selectedCards = []
            }
        } else {
            //TODO: throw error here
            print("Button index not found in buttonAction()", cardButtons.count)
        }
    }


}

