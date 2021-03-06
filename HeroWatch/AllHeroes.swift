//
//  AllHeroes.swift
//
//
//  Created by Matthew Rocco on 7/26/16.
//
//

import UIKit

class AllHeroes: NSObject {
    
    enum Value {
        case Eliminations, Healing, Damage, Deaths, Gold, Silver, Bronze
    }
    
    private var JSON : [String : AnyObject]!
    
    init (JSON : [String : AnyObject]) {
        self.JSON = JSON
    }
    
    func get (value : Value) -> AnyObject {
        var string : AnyObject!
        switch value {
        case .Eliminations:
            string = JSON["Eliminations"] as! String
            
        case .Healing:
            string = JSON["HealingDone"] as! String
            
        case .Damage:
            string = JSON["DamageDone"] as! String
            
        case .Deaths:
            string = JSON["Deaths"] as! String
            
        case .Gold:
            string = JSON["Medals-Gold"] as! String
            
        case .Silver:
            string = JSON["Medals-Silver"] as! String
            
        case .Bronze:
            string = JSON["Medals-Bronze"] as! String
        }
        return String(string).removeComma()
    }
    
}



