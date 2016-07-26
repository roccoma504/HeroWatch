//
//  Heroes.swift
//
//
//  Created by Matthew Rocco on 7/26/16.
//
//

import UIKit

class Heroes: NSObject {
    
    enum Value {
        case Eliminations, Healing, Damage, Deaths, Gold, Silver, Bronze
    }
    
    private var JSON : [String : AnyObject]!
    
    init (JSON : [String : AnyObject]) {
        self.JSON = JSON
    }
    
    func get (value : Value) -> AnyObject {
        switch value {
        case .Eliminations:
            return JSON["Eliminations"] as! String
            
        case .Healing:
            return JSON["HealingDone"] as! String
            
        case .Damage:
            return JSON["DamageDone"] as! String
            
        case .Deaths:
            return JSON["Deaths"] as! String
            
        case .Gold:
            return JSON["Medals-Gold"] as! String
            
        case .Silver:
            return JSON["Medals-Silver"] as! String
            
        case .Bronze:
            return JSON["Medals-Bronze"] as! String
        }
    }
    
}
