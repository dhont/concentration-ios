//
//  Card.swift
//  Concentration Storyboard
//
//  Created by Dragos Hont on 24/12/2019.
//  Copyright © 2019 Dragos Hont. All rights reserved.
//

import Foundation

struct Card{
    var isFaceDown = true
    var isMatched = false
    var identifier: Int
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        
        identifierFactory += 1
        return identifierFactory
    }
    
    static func resetIdentifiers(){
        identifierFactory = 0
    }
    
    init(){
        self.identifier = Card.getUniqueIdentifier()
    }
}
