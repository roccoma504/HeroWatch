//
//  User.swift
//
//
//  Created by Matthew Rocco on 7/26/16.
//
//

import UIKit

class User: NSObject {
    
    enum Value {
        case UserName, Level, Rank, QW, QL, CW, CL, Avatar, RankImg
    }
    
    private var JSON : [String : AnyObject]!
    
    init (JSON : [String : AnyObject]) {
        self.JSON = JSON
    }
    
    func get (value : Value) -> AnyObject {
        switch value {
        case .UserName:
            return JSON["data"]!["username"] as! String
            
        case .Level:
            return JSON["data"]!["level"] as! Int
            
        case .Rank:
            return JSON["data"]!["competitive"]!!["rank"] as! String
            
        case .QW:
            return JSON["data"]!["games"]!!["quick"]!!["wins"] as! String
            
        case .QL:
            return String(JSON["data"]!["games"]!!["quick"]!!["lost"] as! Int)
            
        case .CW:
            return JSON["data"]!["games"]!!["competitive"]!!["wins"] as! String
            
        case .CL:
            return String(JSON["data"]!["games"]!!["competitive"]!!["lost"] as! Int)
            
        case .Avatar:
            return JSON["data"]!["avatar"] as! String
            
        case .RankImg:
            return JSON["data"]!["competitive"]!!["rank_img"] as! String

        }
    }
    
}
