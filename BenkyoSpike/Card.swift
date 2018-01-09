//
//  Card.swift
//  BenkyoSpike
//
//  Created by Jason Cheladyn on 12/13/17.
//  Copyright © 2017 Liyicky. All rights reserved.
//

import Foundation

class Card {
    let frontText:String
    let backText:String
    var flipped = false
    
    init(dict:NSDictionary) throws {
        guard let front = dict["front"] as? String else {
            throw CardParseError.failed("no front value found")
        }
        guard let back = dict["back"] as? String else {
            throw CardParseError.failed("no back value found")
        }
        frontText = front
        backText = back
    }
}


enum CardParseError:Error {
    case failed( _:String)
}
