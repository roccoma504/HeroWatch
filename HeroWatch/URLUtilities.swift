//
//  URLUtilities.swift
//  HeroWatch
//
//  Created by Matthew Rocco on 7/19/16.
//  Copyright © 2016 Matthew Rocco. All rights reserved.
//

import UIKit

class URLUtilities {
    
    static func profileURL(platform : String, region : String, userID : String) -> NSURL {
        return NSURL(string : (BASE_URL)+"/"+(platform)+"/"+(region)+"/"+(userID)+"/profile")!
    }
    
    static func allHero(platform : String, region : String, userID : String) -> NSURL {
        return NSURL(string :(BASE_URL)+"/"+(platform)+"/"+(region)+"/"+(userID)+"/heroes")!
    }
    
    static func quickHeroesURL(platform : String, region : String, userID : String, hero : String) -> NSURL {
        return NSURL(string :(BASE_URL)+"/"+(platform)+"/"+(region)+"/"+(userID)+"/quick-play/hero"+"/"+hero+"/")!
    }
    
    static func compHeroesURL(platform : String, region : String, userID : String, hero : String) -> NSURL {
        return NSURL(string :(BASE_URL)+"/"+(platform)+"/"+(region)+"/"+(userID)+"/competitive-play/hero"+"/"+hero+"/")!
    }
    
    static func quickPlayURL(platform : String, region : String, userID : String) -> NSURL {
        return NSURL(string : (BASE_URL)+"/"+(platform)+"/"+(region)+"/"+(userID)+"/quick-play/allHeroes/")!
    }
    
    static func compPlayURL(platform : String, region : String, userID : String) -> NSURL {
        return NSURL(string :(BASE_URL)+"/"+(platform)+"/"+(region)+"/"+(userID)+"/competitive-play/allHeroes/")!
    }
    
}

