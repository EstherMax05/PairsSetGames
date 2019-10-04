//
//  ConcentrationThemeChooserViewController.swift
//  Concentration
//
//  Created by Esther Max-Onakpoya on 8/15/19.
//  Copyright © 2019 Esther Max-Onakpoya. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController, UISplitViewControllerDelegate {
    
    override func awakeFromNib() {
        splitViewController?.delegate = self
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        if let cvc = secondaryViewController as? ConcentrationViewController {
            if cvc.chosenTheme == nil {
                return true
            }
        }
        return false
    }
    
    @IBOutlet weak var animalTheme: UIButton!

    @IBOutlet weak var plantTheme: UIButton!

    @IBOutlet weak var vehicleTheme: UIButton!

    @IBOutlet weak var fruitTheme: UIButton!

    @IBOutlet weak var emojiTheme: UIButton!

    @IBOutlet weak var blackTheme: UIButton!

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        
        if segue.identifier == "ChooseTheme" {
            
            if let button = sender as? UIButton {
                let theme: Theme?
                switch button {
                case animalTheme:
                    theme = gameThemes[ThemeChooser.animalTheme.rawValue]
                case plantTheme:
                    theme = gameThemes[ThemeChooser.plantTheme.rawValue]
                case vehicleTheme:
                    theme = gameThemes[ThemeChooser.vehicleTheme.rawValue]
                case fruitTheme:
                    theme = gameThemes[ThemeChooser.fruitTheme.rawValue]
                case emojiTheme:
                    theme = gameThemes[ThemeChooser.emojiTheme.rawValue]
                case blackTheme:
                    theme = gameThemes[ThemeChooser.blackTheme.rawValue]
                default:
                    theme = gameThemes[ThemeChooser.blackTheme.rawValue]
                }
                if let cvc = segue.destination as? ConcentrationViewController {
                    cvc.chosenTheme = theme
                }
            }

        }
    }

}
