//
//  ViewConstants.swift
//  Concentration
//
//  Created by Esther Max-Onakpoya on 8/17/19.
//  Copyright © 2019 Esther Max-Onakpoya. All rights reserved.
//

import Foundation

let gameThemes = [ThemeChooser.emojiTheme.rawValue: Theme(emojis: ["😀", "😃", "🤣" , "🤗", "🤩", "🙄", "😉", "😁", "😍", "🥰", "🤣"], cardFaceDownColor: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1), backgroundColor: #colorLiteral(red: 1, green: 0.9662115597, blue: 0.8550192006, alpha: 1), labelColors: #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)),
                  ThemeChooser.blackTheme.rawValue : Theme(emojis: ["🤦🏿‍♀️", "💃🏿", "🕺🏿", "🤛🏿", "🙌🏿", "👍🏿", "🙏🏿", "🤞🏿", "✌🏿", "💪🏿"], cardFaceDownColor: #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1), backgroundColor: #colorLiteral(red: 0.3098039329, green: 0.2039215714, blue: 0.03921568766, alpha: 1), labelColors: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)),
                  ThemeChooser.animalTheme.rawValue : Theme(emojis: ["🐶", "🐱", "🐹", "🐷", "🐧", "🐒", "🦉", "🐝", "🐢", "🦐"], cardFaceDownColor: #colorLiteral(red: 0.6997145443, green: 1, blue: 0.966940193, alpha: 1), backgroundColor: #colorLiteral(red: 0.1937368512, green: 0.6985268593, blue: 0.9121492505, alpha: 1), labelColors: #colorLiteral(red: 0, green: 0.2, blue: 0.6274509804, alpha: 1)),
                  ThemeChooser.plantTheme.rawValue : Theme(emojis: ["🎄", "🌳", "🌴", "☘️", "🍁", "🌷", "🌸", "🌻", "💐", "🌾"], cardFaceDownColor: #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1), backgroundColor: #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1), labelColors: #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)),
                  ThemeChooser.fruitTheme.rawValue : Theme(emojis: ["🍏", "🍎", "🍐", "🍋", "🍊", "🍌", "🍉", "🍇", "🍓", "🍍", "🥝"], cardFaceDownColor: #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1), backgroundColor: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), labelColors: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)),
                  ThemeChooser.vehicleTheme.rawValue : Theme(emojis: ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚚"], cardFaceDownColor: #colorLiteral(red: 0.9882062078, green: 0.9095335603, blue: 0.03830014169, alpha: 1), backgroundColor: #colorLiteral(red: 0.3665645123, green: 0.4276517034, blue: 0.5470500588, alpha: 1), labelColors: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))]
let matchedColor = "✅"
let intialScore = 50
let initialFlipCount = 0
