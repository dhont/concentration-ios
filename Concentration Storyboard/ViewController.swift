//
//  ViewController.swift
//  Concentration Storyboard
//
//  Created by Dragos Hont on 23/12/2019.
//  Copyright © 2019 Dragos Hont. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2 )
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBOutlet weak var labelScore: UILabel!
    @IBOutlet weak var labelCongrats: UILabel!
    @IBOutlet weak var flipCountrLabel: UILabel!
    

    @IBAction func resetGame(_ sender: UIButton) {
        Card.resetIdentifiers()
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2 )
        emojiChoices = setTheme()
        updateViewFromModel()
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender){

            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    /// verifies that the cards are matching; make sure all the cards match
    func updateViewFromModel(){
        for index in cardButtons.indices{
            let card = game.cards[index] // get the coresponding card from model
            let button = cardButtons[index]
            
            if card.isFaceDown {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            } else {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            }
        }
        flipCountrLabel.text = "Flips: \(game.numberOfFlips)"
        labelScore.text = "Score: \(game.curentScore())"
        
        if game.isGameOver{
            for index in cardButtons.indices{
                cardButtons[index].backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0)
                cardButtons[index].setTitle("", for: UIControl.State.normal)
            }
            flipCountrLabel.text = ""
            labelCongrats.text  = "Congratulations, you scored \(100-game.numberOfFlips) points!"
            labelCongrats.isHidden = false
        } else {
            labelCongrats.isHidden = true
        }
            
    }
    
    lazy var emojiChoices = setTheme()
    
    func setTheme() -> [String] {
        var availableThemes = Dictionary<Int,[String]>()
        
        availableThemes[0] = ["🧥", "🥼", "👚", "👕", "👖", "🧵", "🧶", "👔", "👗", "👙", "👘", "🧢", "🧦", "👡", "👠", "🎩"]
        availableThemes[1] = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯", "🦁", "🐮", "🐷", "🐽", "🐸", "🐵"]
        availableThemes[2] = ["🐙", "🦑", "🦐", "🦞", "🐡", "🐠", "🐟", "🐋", "🦈", "🐊", "🐳", "🐢", "🐍", "🦎", "🐸", "🦀"]
        availableThemes[3] = ["🌵", "🌲", "🌳", "🌴", "🌱", "🌿", "☘", "🎍", "🎋", "🍃", "🍂", "🍁", "🍄", "🌾", "🎄", "🍀"]
        availableThemes[4] = ["🍏", "🍎", "🍐", "🍋", "🍌", "🍇", "🍓", "🍈", "🍒", "🥭", "🍍", "🥥", "🥝", "🍅", "🍑", "🍉"]
        availableThemes[5] = ["🤲", "👐", "🙌", "👏", "🤝", "👍", "👎", "👊", "✊", "🤛", "🤞", "✌", "🤟", "👈", "🖖"]
        
        let randomThemeIndex = Int(arc4random_uniform(UInt32(availableThemes.count)))
        playableEmoji = [Int:String]()
        
        return (availableThemes[randomThemeIndex])!
    }
    
    var playableEmoji = [Int:String]() //dictionary
    
    func emoji(for card: Card) -> String {
        if playableEmoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            playableEmoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return playableEmoji[card.identifier] ?? "?"
    }
    
}

