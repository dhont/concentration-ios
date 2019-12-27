//
//  Concentration.swift
//  Concentration Storyboard
//
//  Created by Dragos Hont on 24/12/2019.
//  Copyright © 2019 Dragos Hont. All rights reserved.
//

import Foundation

class Concentration
{
    var cards = [Card]()
    
    var numberOfFlips = 0
    
    var pointsGiven = 0
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    var isGameOver = false
    
    var previouslySeenCards: Dictionary<Int,Int>
    
    func curentScore () -> Int {
       // return pointsGiven + previouslySeenCards.filter({$0 > 1}).reduce(0, +)
        
        return 100 - numberOfFlips
    }
    
    func chooseCard(at index: Int){

        // ignore already match cards
        if !cards[index].isMatched, cards[index].isFaceDown, !isGameOver {
            numberOfFlips += 1
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    pointsGiven += 2
                } else{
                // mismatched
                    // previouslySeenCards[cards[index].identifier] += 1
                }
                cards[index].isFaceDown = false
                indexOfOneAndOnlyFaceUpCard = nil
                // previouslySeenCards[cards[index].identifier] += 1
            } else {
                for flipDownCards in cards.indices{
                    cards[flipDownCards].isFaceDown = true
                }
                cards[index].isFaceDown = false
                indexOfOneAndOnlyFaceUpCard = index
                // previouslySeenCards[cards[index].identifier] += 1
            }
            evaluateIfGameOver()
        }
    }
    
    func evaluateIfGameOver(){
        let matched = cards.filter({!$0.isMatched}).count
        if  matched == 0 {
            self.isGameOver = true
        }
    }
    
    init(numberOfPairsOfCards: Int){

        let numberOfCards = numberOfPairsOfCards * 2
        var allIndexes =  [Int](0..<numberOfCards)
        var emptyCardsArray: [Card?] = Array(repeating: nil, count: numberOfCards)
        previouslySeenCards = Dictionary<Int, Int>()

        for _ in 1...numberOfPairsOfCards {
            var firstRandomCardIndex = Int(arc4random_uniform(UInt32(allIndexes.count)))
            firstRandomCardIndex = allIndexes.remove(at: firstRandomCardIndex)
            var secondRandomCardIndex = Int(arc4random_uniform(UInt32(allIndexes.count)))
            secondRandomCardIndex = allIndexes.remove(at: secondRandomCardIndex)
            
            let card = Card()
            emptyCardsArray[firstRandomCardIndex] = card
            emptyCardsArray[secondRandomCardIndex] = card
            //previouslySeenCards.add
            cards = emptyCardsArray.compactMap{$0}
        }
    }
}
