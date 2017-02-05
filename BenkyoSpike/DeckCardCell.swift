//
//  DeckCell.swift
//  BenkyoSpike
//
//  Created by Jason Cheladyn on 11/21/16.
//  Copyright © 2016 Liyicky. All rights reserved.
//

import UIKit

class DeckCardCell: UICollectionViewCell {
    
    //#MARK: Statics
    static let identifier = "DeckCardCell"
    
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    //#MARK: Properties
  
    
    var cardFront = DeckCardFrontView.Card()
    var cardBack  = DeckCardBackView.Card()
    var flipped   = false

    enum ChangoSpellError: Error {
        case hatMissingOrNotMagical
        case noFamiliar
        case familiarAlreadyAToad
        case spellFailed(reason: String)
        case spellNotKnownToWitch
    }

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let cardrect = CGRect(x: 0, y: 0, width: DeckCollectionViewLayout.cardSize.width, height: DeckCollectionViewLayout.cardSize.height)
        
                
        cardBack.frame  = cardrect
        cardFront.frame = cardrect
        addSubview(cardFront)
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(DeckCardCell.tapped))
        tap.numberOfTapsRequired = 1
        contentView.addGestureRecognizer(tap)
        contentView.isUserInteractionEnabled = true
        
        
        DatabaseThing().setupDB()
        DatabaseThing().addTestData()
        let db = DatabaseThing().theDB()
        
        
        for card in try! db.prepare(DatabaseThing().cards) {
            print("id: \(card[DatabaseThing().id]), email: \(card[DatabaseThing().frontText])")
        }
        

     
    }
    
    
    func tapped() {
        NSLog("\(DeckCardCell.identifier) :Tapped!")
        flipCard(animated: true)
    }
    
    func flipCard(animated:Bool=false) {
        let dur:TimeInterval = animated ? 0.5 : 0
        if flipped {
            UIView.transition(from: cardBack, to: cardFront, duration: dur, options: UIViewAnimationOptions.transitionFlipFromLeft, completion: nil)
        }else{
            UIView.transition(from: cardFront, to:cardBack , duration: dur, options: UIViewAnimationOptions.transitionFlipFromRight, completion: nil)
        }
        flipped = !flipped
    }
    
}

class CardView: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        // Cell Corner and Shadows
        layer.cornerRadius = 10
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.6
        layer.borderWidth = 1
        // Emphasize the shadow on the bottom and right sides of the cell
        layer.shadowOffset = CGSize(width: 4, height: 4)
        
        
    }
}


