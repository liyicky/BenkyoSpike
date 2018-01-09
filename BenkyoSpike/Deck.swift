//
//  Deck.swift
//  BenkyoSpike
//
//  Created by Jason Cheladyn on 12/13/17.
//  Copyright © 2017 Liyicky. All rights reserved.
//

import Foundation

class Deck {
    static let shared = Deck()
    
    
    private var _cards:[Card] = []
    var cards:[Card] { return _cards }
    
    private init() {
        _cards = try! loadDeck(deckName: "Cards")
    }
    private func loadDeck(deckName:String) throws -> [Card]{
        guard let filepath = Bundle.main.path(forResource: deckName, ofType: "plist"),
        let data = NSArray.init(contentsOfFile: filepath) as? [NSDictionary] else {
            throw CardParseError.failed("failed to parse deck")
        }
        
       return try data.map({ (dict) -> Card in
            return try Card(dict: dict)
        })
        
    }
    func clear(){
        _cards = []
    }
}


