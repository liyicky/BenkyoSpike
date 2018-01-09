//
//  URL+.swift
//  BenkyoSpike
//
//  Created by Jason Cheladyn on 1/9/18.
//  Copyright © 2018 Liyicky. All rights reserved.
//

import Foundation

enum Server {
    
    case localhost, live, server1
    
    private var secure:Bool {
        switch self {
        case .live, .server1:
            return true
        default:
            return false
        }
    }
    private var base:String {
        switch self {
        case .live:
            return "example.com"
        case .localhost:
            return "localhost"
        case  .server1:
            return "foo"
        }
    }
    var url:URL {
        return URL.init(string: "\(secure ? "https":"http" )://\(base)")!
    }
    func  openURL(){
    }
}

