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
    
    let itemsPerRow = 4
    
    var consentration = Concentration()
    var matchIds: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardsCollectionView.delegate = self
        cardsCollectionView.dataSource = self
        
        consentration.newGame(cardsSet: 6)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return consentration.cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCollectionViewCell", for: indexPath) as! CardCollectionViewCell
        
        let data = consentration.cards[indexPath.item]
        cell.emojiLabel.text = data.isFlip ? data.title : ""
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.consentration.cards.enumerated().forEach({ index, item in
            if item.isMatch {
                let index = IndexPath(item: index, section: 0)
                let cell = collectionView.cellForItem(at: index)
                cell?.isHidden = true
            }
        })
        
        UIView.performWithoutAnimation {
            consentration.selectedCard(cardIndex: indexPath.item)
            collectionView.reloadItems(at: [indexPath])
            
            self.consentration.cards.enumerated().forEach({ index, item in
                if !item.isFlip && !item.isMatch {
                    let index = IndexPath(item: index, section: 0)
                    collectionView.reloadItems(at: [index])
                }
            })
        }
        
        // TODO: if all match should display newGame or You Win alert!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width / 4) - (5 + (10 / 4))
        return CGSize(width: width, height: width * 1.3)
    }
}
