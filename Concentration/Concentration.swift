//
//  Concentration.swift
//  Concentration
//
//  Created by Sopoat Iamcharoen on 10/12/2566 BE.
//

import Foundation

struct Card {
    var title: String
    var isMatch: Bool
    var isFlip: Bool
    var identifier: Int
}

class Concentration {
    static var thame: [String:[String]] = 
    [
        "faces": ["😀","😢","😉", "😝", "😍", "🥳"],
        "christmas": ["🎄","🌲","🎅🏻", "🧑🏻‍🎄", "❄️", "⛄️"],
    ]
    
    static
    
    var score = 0
    var flips = 0
    var timer = 0
    
    var cards: [Card] = []
    
    func newGame(cards: Int) {
        
    }
    
    func selectedCard(){
        // when user selected card
    }
}
