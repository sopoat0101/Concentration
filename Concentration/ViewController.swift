//
//  ViewController.swift
//  Concentration
//
//  Created by Sopoat Iamcharoen on 9/12/2566 BE.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var cardsCollectionView: UICollectionView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var flipsLabel: UILabel!
    
    @IBOutlet weak var informationView: UIView!
    
    @IBOutlet weak var summaryView: UIView!
    @IBOutlet weak var summaryTimeLabel: UILabel!
    @IBOutlet weak var summaryFlipsLabel: UILabel!
    @IBOutlet weak var summaryScoreLabel: UILabel!
    
    @IBOutlet weak var newGameButton: UIButton!
    
    let itemsPerRow = 4
    
    var consentration = Concentration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardsCollectionView.delegate = self
        cardsCollectionView.dataSource = self
        
        newGameButton.addTarget(self, action: #selector(newGame), for: .touchUpInside)
        newGame()
    }
    
    let theme: [GameTheme] = [
        GameTheme(name: "faces", emojis: ["😀","😢","😉", "😝", "😍", "🥳"], backCardColor: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1), frontCardColor: #colorLiteral(red: 1, green: 0.5792264342, blue: 0.2695806026, alpha: 1)),
        GameTheme(name: "christmas", emojis: ["🎄","🌲","🎅🏻", "🧑🏻‍🎄", "❄️", "⛄️"], backCardColor: #colorLiteral(red: 0.1556423903, green: 0.3056026995, blue: 0.1985731423, alpha: 1), frontCardColor: #colorLiteral(red: 0.740604341, green: 0.1924909949, blue: 0.2376689613, alpha: 1))
    ]
    
    func randomTheme() -> Int {
        let random = Int.random(in: 0..<theme.count)
        return random
    }
    
    var identifierAndEmoji: [Int:String] = [:]
    var selectTheme: GameTheme?
    
    func mapIdentifierAndEmoji() {
        let themeIndex = randomTheme()
        let selectTheme = theme[themeIndex]
        let setId = Set(consentration.cards.map({ $0.identifier }))
        guard setId.count <= selectTheme.emojis.count else { return }
        for (index, id) in setId.enumerated() {
            if identifierAndEmoji[id] == nil {
                identifierAndEmoji[id] = selectTheme.emojis[index]
            }
        }
        self.selectTheme = selectTheme
    }
    
    @objc func newGame(){
        consentration.newGame(cardsSet: 6)
        summaryView.isHidden = true
        summaryFlipsLabel.text = "\(consentration.flips)"
        summaryScoreLabel.text = "\(consentration.score)"
        identifierAndEmoji = [:]
        mapIdentifierAndEmoji()
        if identifierAndEmoji.isEmpty {
            let alert = UIAlertController(title: "Fail", message: "Emoji not enough.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "done", style: .cancel))
        }
        informationView.backgroundColor = selectTheme?.backCardColor
        hideAndShowCard()
        cardsCollectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return consentration.cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCollectionViewCell", for: indexPath) as! CardCollectionViewCell
        
        let data = consentration.cards[indexPath.item]
        cell.emojiLabel.text = data.isFlip ? identifierAndEmoji[data.identifier] : ""
        cell.contentView.backgroundColor = data.isFlip ? selectTheme?.frontCardColor : selectTheme?.backCardColor
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        hideAndShowCard()
        
        UIView.performWithoutAnimation {
            consentration.selectedCard(cardIndex: indexPath.item)
            collectionView.reloadItems(at: [indexPath])
            
            self.consentration.cards.enumerated().forEach({ index, item in
                if !item.isFlip && !item.isMatch {
                    let index = IndexPath(item: index, section: 0)
                    collectionView.reloadItems(at: [index])
                }
            })
            
            flipsLabel.text = "Flips: \(consentration.flips)"
            scoreLabel.text = "Score: \(consentration.score)"
            summaryFlipsLabel.text = "\(consentration.flips)"
            summaryScoreLabel.text = "\(consentration.score)"
        }
        
        if consentration.isGameEnd() {
            summaryView.isHidden = false
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width / 4) - (5 + (10 / 4))
        return CGSize(width: width, height: width * 1.3)
    }
    
    func hideAndShowCard(){
        self.consentration.cards.enumerated().forEach({ index, item in
            let index = IndexPath(item: index, section: 0)
            let cell = cardsCollectionView.cellForItem(at: index)
            if item.isMatch {
                cell?.isHidden = true
            } else {
                cell?.isHidden = false
            }
        })
    }
}

struct GameTheme {
    let name: String
    let emojis: [String]
    let backCardColor: UIColor
    let frontCardColor: UIColor
}
