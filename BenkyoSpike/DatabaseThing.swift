//
//  DatabaseThing.swift
//  BenkyoSpike
//
//  Created by Jason Cheladyn on 1/28/17.
//  Copyright © 2017 Liyicky. All rights reserved.
//

import SQLite
import Foundation

class DatabaseThing {
    let path = NSSearchPathForDirectoriesInDomains(
        .documentDirectory, .userDomainMask, true
        ).first!
    
    let cards  = Table("cards")
    
    let id         = Expression<Int64>("id")
    let frontText  = Expression<String>("frontText")
    let backText   = Expression<String>("backText")
    
    
    func setupDB() {
        
   
        
    let db     = try! Connection("\(path)/theDB.sqlite3")
        
//        lazy load this
//       try! db.run(cards.create { t in
//            t.column(id, primaryKey: .autoincrement)
//            t.column(frontText)
//            t.column(backText)
//        })
    }
    
    func theDB() -> Connection {
        let db     = try! Connection("\(path)/theDB.sqlite3")
        return db
    }
    
    func addTestData() {
        let db     = try! Connection("\(path)/theDB.sqlite3")
        try! db.run(cards.insert(frontText <- "Liyickywashere", backText <- "Wasn't Here"))
    }
  
    
}




