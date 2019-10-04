//
//  GraphicalSetCardView.swift
//  GraphicalSetGame
//
//  Created by Esther Max-Onakpoya on 7/3/19.
//  Copyright © 2019 Esther Max-Onakpoya. All rights reserved.
//

import UIKit

//@IBDesignable
class GraphicalSetCardView: UIView {
    
    var isDealThreeButtonVisible = true
    
    var rank: Int = 5 {
        didSet{
            setNeedsDisplay()
            setNeedsLayout()
        }
    }
    var suit: String = "❤️"{
        didSet{
            setNeedsDisplay()
            setNeedsLayout()
        }
    }
    
    var themeColor: UIColor = #colorLiteral(red: 0.2514673223, green: 0.2427509376, blue: 0.2166017833, alpha: 1) {
        didSet {
            setNeedsDisplay()
            setNeedsLayout()
        }
    }
    
    var setCards: [SetCard] = [] {
        didSet {
            setNeedsDisplay()
            setNeedsLayout()
        }
    }
    
    var numberOfCardsDisplayed: Int = 12 {
        didSet {
            setNeedsDisplay()
            setNeedsLayout()
        }
    }
    
    var grid = Grid(layout: .aspectRatio(0.65)) {
        didSet{
            setNeedsDisplay()
            setNeedsLayout()
        }
    }
    
    private var cornerString: NSAttributedString {
        return centeredAttributedString(String(rank)+"\n"+suit, fontSize: 0.0)
    }
    
    private(set) var selectedIndices = [Int]()
     
    private(set) var selectedCards = [SetCard]()
     
    private(set) var cardButtons: [UIButton] = []
     
    private var cardButtonsTaps: [Int] = []
     
    var newCell = CGRect(x: 0, y: 0, width: 0, height: 0)
     
     var viewIndex = 0 {
         didSet {
             layoutIfNeeded()
         }
     }
     
     var trans = false

    private func centeredAttributedString(_ string: String, fontSize: CGFloat) -> NSAttributedString {
        var font = UIFont.preferredFont(forTextStyle: .body).withSize(fontSize)
        font = UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        return NSAttributedString(string: string, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle, NSAttributedString.Key.font: font])
    }
    
    func shapeDesign(with card: SetCard, in localRect: CGRect) {
        // make sure that number isn't less than 3 in VC
        //for card in cards {
        switch card.shape {
        case .oval:
            ovalShapeDesign(in: localRect, numberOfOvals: card.numberOfShapes, ovalColor: card.color, ovalTexture: card.texture)
        case .diamond:
            diamondShapeDesign(in: localRect, numberOfDiamonds: card.numberOfShapes, diamondColor: card.color, diamondTexture: card.texture)
        case .squiggle:
            squigglesShapeDesign(in: localRect, numberOfSquiggles: card.numberOfShapes, squiggleColor: card.color, squiggleTexture: card.texture)
            
        }
    }
    
    private func ovalShapeDesign(in bounds: CGRect, numberOfOvals: Int = 2, ovalColor: CardColor = CardColor.red, ovalTexture: Texture = Texture.hollow) {
        
        let scale = min(bounds.width/CGFloat(numberOfOvals), bounds.height/CGFloat(numberOfOvals))
        
        let context = UIGraphicsGetCurrentContext()!
        
        for num in 0..<numberOfOvals {
            let oval = UIBezierPath()
            
            let point_0 = CGPoint(x: (0.5*scale)+(CGFloat(num)*scale)+bounds.minX, y: (0.5*scale)+bounds.minY)
            let point_1 = CGPoint(x: (0.5*scale)+(CGFloat(num)*scale)+bounds.minX, y: (1.2*scale)+bounds.minY)
            let radius = 0.2*scale
            
            oval.addArc(withCenter: point_0, radius: radius, startAngle: 0, endAngle: CGFloat.pi, clockwise: false)
            oval.addLine(to: CGPoint(x: oval.currentPoint.x, y: point_1.y))
            oval.addArc(withCenter: point_1, radius: radius, startAngle: CGFloat.pi, endAngle: 0, clockwise: false)
            oval.addLine(to: CGPoint(x: oval.currentPoint.x, y: point_0.y))
            
            ovalColor.value.setStroke()
            context.saveGState()
            oval.addClip()
            if ovalTexture == Texture.striped {
                for number in stride(from: -floor(bounds.minX+scale/2), to: bounds.minX+scale, by: 3) {
                    oval.move(to: CGPoint(x: CGFloat(number)+oval.bounds.midX, y: oval.bounds.maxY))
                    oval.addLine(to: CGPoint(x: CGFloat(number)+oval.bounds.midX, y: oval.bounds.minY))
                }
            } else if ovalTexture == Texture.filled {
                ovalColor.value.setFill()
                oval.fill()
            }
            
            oval.stroke()
            
            context.restoreGState()
        }
    }
    
    private func diamondShapeDesign(in bounds: CGRect, numberOfDiamonds: Int = 3, diamondColor: CardColor = CardColor.red, diamondTexture: Texture = Texture.hollow) {
        
        let scale = min(bounds.width/CGFloat(numberOfDiamonds), bounds.height/CGFloat(numberOfDiamonds))
        
        let context = UIGraphicsGetCurrentContext()!
        
        for num in 0..<numberOfDiamonds {
            let diamond = UIBezierPath()
            
            let point_0 = CGPoint(x: (0.5*scale)+(CGFloat(num)*scale)+bounds.minX, y: (1.2*scale)+bounds.minY)
            let point_1 = CGPoint(x: (0.5*scale)+(CGFloat(num)*scale)+bounds.minX, y: (0.1*scale)+bounds.minY)
            let point_2 = CGPoint(x: (0.2*scale)+(CGFloat(num)*scale)+bounds.minX, y: (0.55*scale)+bounds.minY)
            let point_3 = CGPoint(x: (0.8*scale)+(CGFloat(num)*scale)+bounds.minX, y: (0.55*scale)+bounds.minY)
            
            diamond.move(to: point_0)
            diamond.addLine(to: point_3)
            diamond.addLine(to: point_1)
            diamond.addLine(to: point_2)
            diamond.addLine(to: point_0)
            
            //diamond.
            diamondColor.value.setStroke()
            context.saveGState()
            diamond.addClip()
            if diamondTexture == Texture.striped {
                for number in stride(from: -floor(bounds.minX+scale/2), to: bounds.minX+scale, by: 3) {
                    diamond.move(to: CGPoint(x: CGFloat(number)+diamond.bounds.midX, y: diamond.bounds.maxY))
                    diamond.addLine(to: CGPoint(x: CGFloat(number)+diamond.bounds.midX, y: diamond.bounds.minY))
                }
            } else if diamondTexture == Texture.filled {
                diamondColor.value.setFill()
                diamond.fill()
            }
            
            diamond.stroke()
            
            context.restoreGState()
        }
    }
    
    private func squigglesShapeDesign(in bounds: CGRect, numberOfSquiggles: Int = 1, squiggleColor: CardColor = CardColor.red, squiggleTexture: Texture = Texture.hollow) {
        
        struct lineProperties {
            var slope: CGFloat
            var y_intercept: CGFloat
        }
        
        func findSlope(_ firstPoint: CGPoint, _ secondPoint: CGPoint) -> lineProperties {
            let slope = (firstPoint.y - secondPoint.y) / (firstPoint.x - secondPoint.x)
            print("y1, y2, x1, x2", firstPoint.y, secondPoint.y, firstPoint.x, secondPoint.x)
            let y_intercept = firstPoint.y - (slope*firstPoint.x)
            print("y_intercept: ", y_intercept)
            print("firstPoint: ", firstPoint)
            print("(slope*firstPoint.x): ", (slope*firstPoint.x))
            return lineProperties(slope: slope, y_intercept: y_intercept)
        }
        
        let context = UIGraphicsGetCurrentContext()!
        
        let scale = min(bounds.width/CGFloat(numberOfSquiggles), bounds.height/CGFloat(numberOfSquiggles))
        for num in 0..<numberOfSquiggles {
            let squiggle = UIBezierPath()
            let point_0 = CGPoint(x: (0.5*scale)+(CGFloat(num)*scale)+bounds.minX, y: (0.1*scale)+bounds.minY)
            let point_1 = CGPoint(x: (0.1*scale)+(CGFloat(num)*scale)+bounds.minX, y: (0.4*scale)+bounds.minY)
            let point_2 = CGPoint(x: (0.4*scale)+(CGFloat(num)*scale)+bounds.minX, y: (0.8*scale)+bounds.minY)
            let point_3 = CGPoint(x: (0.1*scale)+(CGFloat(num)*scale)+bounds.minX, y: (1.4*scale)+bounds.minY)
            let point_4 = CGPoint(x: (0.5*scale)+(CGFloat(num)*scale)+bounds.minX, y: (1.5*scale)+bounds.minY)
            let point_5 = CGPoint(x: (0.9*scale)+(CGFloat(num)*scale)+bounds.minX, y: (1.1*scale)+bounds.minY)
            let point_6 = CGPoint(x: (0.5*scale)+(CGFloat(num)*scale)+bounds.minX, y: (0.8*scale)+bounds.minY)
            let point_7 = CGPoint(x: (0.9*scale)+(CGFloat(num)*scale)+bounds.minX, y: (0.2*scale)+bounds.minY)
            
            squiggle.move(to: point_0)
            squiggle.addCurve(to: point_3, controlPoint1: point_1, controlPoint2: point_2)
            squiggle.addCurve(to: point_6, controlPoint1: point_4, controlPoint2: point_5)
            squiggle.addCurve(to: point_0, controlPoint1: point_7, controlPoint2: point_1)
            squiggleColor.value.setStroke()
            context.saveGState()
            squiggle.addClip()
            
            if squiggleTexture == Texture.striped {
                for number in stride(from: -floor(bounds.minX+scale/2), to: bounds.minX+scale, by: 3) {
                    squiggle.move(to: CGPoint(x: CGFloat(number)+squiggle.bounds.midX, y: squiggle.bounds.maxY))
                    squiggle.addLine(to: CGPoint(x: CGFloat(number)+squiggle.bounds.midX, y: squiggle.bounds.minY))
                }
            } else if squiggleTexture == Texture.filled {
                squiggleColor.value.setFill()
                squiggle.fill()
            }
            
            squiggle.stroke()
            
            context.restoreGState()
        }
    }
    
    func drawCardOutline(in rect: CGRect) {
        let cardOutline = UIBezierPath(roundedRect: rect, cornerRadius:min(rect.width, rect.height)*0.2)
        themeColor.setStroke()
        cardOutline.stroke()
        #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).setFill()
        cardOutline.fill()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func selectCard(with cardIndex: Int) {
        cardButtons[cardIndex].layer.borderWidth = 3.0
        cardButtons[cardIndex].layer.borderColor = UIColor.blue.cgColor
    }
    
    func selectCardButton(with button: UIButton) {
        button.layer.borderWidth = 4.0
        button.layer.cornerRadius = 9.0
        button.layer.borderColor = UIColor.blue.cgColor
    }
    
    func deselectCard(with cardIndex: Int) {
        cardButtons[cardIndex].layer.borderWidth = 0.0
    }
    
    func deselectCardButton(with button: UIButton) {
        button.layer.borderWidth = 0.0
    }
    
    func drawDeck(in rect: CGRect) {
        let cardOutline = UIBezierPath(roundedRect: rect, cornerRadius:min(rect.width, rect.height)*0.2)
        for _ in 0..<3 {
            themeColor.setStroke()
            cardOutline.stroke()
            #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).setFill()
            cardOutline.fill()
        }
        
    }
    
    
    override func draw(_ rect: CGRect) {
        let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: 16.0)
        roundedRect.addClip()
        #colorLiteral(red: 0.9234092072, green: 0.9234092072, blue: 0.9234092072, alpha: 0.5).setFill()
        let gridRect = CGRect(origin: rect.origin, size: CGSize(width: rect.width, height: rect.height))
        
        grid = Grid(layout: .aspectRatio(0.65), frame: gridRect)
        
        grid.cellCount = setCards.count //get from vc
        
        var cellCardCount = 0
        
        for cell in grid.cellFrames {
            newCell = cell.insetBy(dx: cell.width*0.08, dy: cell.height*0.05)
            drawCardOutline(in: newCell)
            shapeDesign(with: setCards[cellCardCount], in: newCell)
            
            cellCardCount += 1
        }
        trans = true
    }
    
    func flyAcross() {
        //TODO: Implement flyAcross() later
    }
    
    func dealWithSelection() { //TODO: Implement dealWithSelection() later
        
        // obtain index (indicies) for view controller
        
        // make sure only <=3 indices are selected
        
        // if 3 indices are selected
    }
    
    @objc func fireTimer() {
        print("Timer fired!")
    }
}
