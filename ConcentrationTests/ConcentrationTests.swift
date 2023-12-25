//
//  ConcentrationTests.swift
//  ConcentrationTests
//
//  Created by Sopoat Iamcharoen on 25/12/2566 BE.
//

import XCTest
@testable import Concentration

final class ConcentrationTests: XCTestCase {

    var gameObject: Concentration!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        gameObject = Concentration()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        gameObject = nil
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testNewGame() {
        // Arrange
        var cardSet = 6
        // Act
        gameObject.newGame(cardsSet: cardSet)
        // Assert
        XCTAssertEqual(gameObject.cards.count, (cardSet * 2), "card in game must be double of set card")
        
        // alternative case
        // Arrange
        cardSet = 7
        // Act
        gameObject.newGame(cardsSet: cardSet)
        // Assert
        XCTAssertEqual(gameObject.cards.count, 0, "card in game must be 0 when cardSet more than 6")
    }
    
    func testResetGame() {
        // Arrange
        let cardSet = 6
        gameObject.newGame(cardsSet: cardSet)
        // Act
        gameObject.resetGame()
        // Assert
        XCTAssertEqual(gameObject.cards.count, 0, "card in game must be 0 when game reset.")
        XCTAssertEqual(gameObject.score, 0, "score in game must be 0 when game reset.")
        XCTAssertEqual(gameObject.flips, 0, "flips count in game must be 0 when game reset.")
    }
    
    func testIsGameEnd() {
        // Arrange
        let cardSet = 6
        gameObject.newGame(cardsSet: cardSet)
        
        // Act
        for i in gameObject.cards.indices {
            gameObject.cards[i].isMatch = true
        }
        // Assert
        XCTAssertTrue(gameObject.isGameEnd(), "isGameEnd must be true when all cards match.")
        
        // alternative case
        
        // Act
        gameObject.cards[0].isMatch = false
        // Assert
        XCTAssertFalse(gameObject.isGameEnd(), "isGameEnd must be false when not all of cards match.")
    }

    func testSelectCard() {
        // Arrange
        let cardIndex = 0
        let cardSet = 6
        gameObject.newGame(cardsSet: cardSet)
        
        // Act
        gameObject.selectedCard(cardIndex: cardIndex)
        let previousCardIndex = gameObject.previousCardIndex
        // Assert
        XCTAssertTrue(gameObject.cards[cardIndex].isFlip, "selected card in first time must flip")
        
        gameObject.selectedCard(cardIndex: cardIndex)
        XCTAssertTrue(gameObject.cards[cardIndex].isFlip, "selected same card in second time isFlip must not change")
        
        XCTAssertEqual(cardIndex, previousCardIndex, "previousCardIndex should same number with fitst time selected")
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
