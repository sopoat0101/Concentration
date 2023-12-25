//
//  Concentration.swift
//  Concentration
//
//  Created by Sopoat Iamcharoen on 10/12/2566 BE.
//

import Foundation

struct Card {
    var isMatch = false
    var isFlip = false
    let identifier: Int
    
    static var identifierFactory = 0
    
    static func getIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init(){
        self.identifier = Card.getIdentifier()
    }
}

class Concentration {
    
    var score = 0
    var flips = 0
    var timer = 0
    
    var cards: [Card] = []
    var previousCardIndex: Int?
    
    func newGame(cardsSet: Int) {
        resetGame()
        
        guard cardsSet <= 6 else {
            resetGame()
            return
        }
        for _ in 0..<cardsSet {
            let card = Card()
            cards += [card, card]
        }
        
        // DO shuffle the deck
        var shuffledDeck: [Card] = []
        for _ in 0..<(cardsSet * 2) {
            let random = Int.random(in: 0..<cards.count)
            shuffledDeck.append(cards[random])
            cards.remove(at: random)
        }
        cards = shuffledDeck
    }
    
    func resetGame(){
        cards = []
        score = 0
        flips = 0
        
        previousCardIndex = nil
    }
    
    func isGameEnd() -> Bool {
        let result = cards.filter({ !$0.isMatch })
        return result.isEmpty
    }
    
    func selectedCard(cardIndex: Int) {
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
