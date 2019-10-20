//
//  Jokers.swift
//  Millionaire
//
//  Created by Laurens on 20.10.19.
//  Copyright © 2019 Laurens K. All rights reserved.
//

import Foundation

struct Joker {
    
    let name: String
    var wasActivated: Bool
    
}

var jokers: [Joker] = [
    
    Joker(name: "fiftyFiftyJoker", wasActivated: false),
    Joker(name: "audienceJoker", wasActivated: false),
    Joker(name: "phoneJoker", wasActivated: false)

]
