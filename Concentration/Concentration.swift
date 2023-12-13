//
//  Concentration.swift
//  Concentration
//
//  Created by Sopoat Iamcharoen on 10/12/2566 BE.
//

import Foundation

struct Card {
    var title: String
    var isMatch = false
    var isFlip = false
    let identifier: Int
    
    static var identifierFactory = 0
    
    static func getIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init(title: String){
        self.title = title
        self.identifier = Card.getIdentifier()
    }
}

class Concentration {
    static var thame: [String:[String]] = 
    [
        "faces": ["😀","😢","😉", "😝", "😍", "🥳"],
        "christmas": ["🎄","🌲","🎅🏻", "🧑🏻‍🎄", "❄️", "⛄️"],
    ]
    
    var score = 0
    var flips = 0
    var timer = 0
    
    var cards: [Card] = []
    var previousCardIndex: Int?
    
    func newGame(cardsSet: Int) {
        guard cardsSet <= 6, let emojis = Concentration.thame["faces"] else {
            return
        }
        for i in 0..<cardsSet {
            let card = Card(title: emojis[i])
            cards += [card, card]
        }
    }
    
    func checkAllMatch() -> Bool {
        let result = self.cards.filter({ $0.isMatch == false })
        return result.isEmpty
    }
    
    func selectedCard(cardIndex: Int){
        // when user selected card
        
        guard !cards[cardIndex].isMatch, cardIndex != previousCardIndex else {
            return
        }
        
        self.flips += 1
        cards[cardIndex].isFlip.toggle()
        
        if let previousCardIndex = previousCardIndex {
            let condition = cards[cardIndex].identifier == cards[previousCardIndex].identifier
            cards[cardIndex].isMatch = condition
            cards[previousCardIndex].isMatch = condition
            self.score += condition ? 2 : 0
            self.previousCardIndex = nil
        } else {
            
            for i in cards.indices {
                cards[i].isFlip = false
            }
            previousCardIndex = cardIndex
            cards[cardIndex].isFlip = true
        }
    }
}
