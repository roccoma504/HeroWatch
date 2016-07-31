//
//  Constants.swift
//  HeroWatch
//
//  Created by Matthew Rocco on 7/19/16.
//  Copyright © 2016 Matthew Rocco. All rights reserved.
//
//  This package contains constants used by the application.
//

import ChameleonFramework
import UIKit


//
// Color constants
//

let PRIMARY_COLOR = FlatOrangeDark()
let SECONDARY_COLOR = FlatBlue()

//
// Platform Constants
//

let CONSOLE_ARRAY = ["psn","xbl","pc"]
let REGION_ARRAY = ["eu", "us", "kr", "cn", "global"]

let BASE_URL = "https://api.lootbox.eu"


//
// Hero related constants
//

enum heroes {
    case Soldier76
    case Hanzo
    case Pharah
    case Genji
    case Tracer
    case Widowmaker
    case Bastion
    case Dva
    case Torbjorn
    case Zenyatta
    case McCree
    case Mercy
    case Roadhog
    case Reaper
    case Symmetra
}

let heroImageMap = ["Soldier: 76":"soldier_76.png",
                    "Hanzo":"hanzo.png",
                    "Pharah":"pharah.png",
                    "Genji":"genji.png",
                    "Tracer":"tracer.png",
                    "Widowmaker":"widowmaker.png",
                    "Bastion":"bastion.png",
                    "D.Va":"dva.png",
                    "Torbj&#xF6;rn":"torbjorn.png",
                    "Zenyatta":"zenyatta.png",
                    "McCree":"mcree.png",
                    "Mercy":"mercy.png",
                    "Roadhog":"roadhog.png",
                    "Reaper":"reaper.png",
                    "Symmetra":"symmetra.png",
                    "Lucio":"lucio.png",
                    "Reinhardt":"reinhardt.png"]

extension String {
    private func replace(string:String, replacement:String) -> String {
        return self.stringByReplacingOccurrencesOfString(string, withString: replacement, options: NSStringCompareOptions.LiteralSearch, range: nil)
    }
    
    func removeWhitespace() -> String {
        return self.replace(" ", replacement: "")
    }
    
    func removeColon() -> String {
        return self.replace(":", replacement: "")
    }
    
    func removeComma() -> String {
        return self.replace(",", replacement: "")
    }
    func trunc(length: Int, trailing: String? = "") -> String {
        if self.characters.count > length {
            return self.substringToIndex(self.startIndex.advancedBy(length)) + (trailing ?? "")
        } else {
            return self
        }
    }
    
    func insert(string:String,ind:Int) -> String {
        return  String(self.characters.prefix(ind)) + string + String(self.characters.suffix(self.characters.count-ind))
    }
    
    
    func addComma() -> String {
        let comma = ","
        
        var newString = self
        var numCommas = 0
        var stringLength = self.characters.count
        
        func magnitude()  {
            if stringLength >= 4 && stringLength < 7 {
                newString = newString.insert(comma, ind: self.characters.count - 3)
            }
            else if stringLength >= 7{
                newString = newString.insert(comma, ind: self.characters.count - 3)
                newString = newString.insert(comma, ind: self.characters.count - 6)
            }
            else if stringLength >= 7{
                newString = newString.insert(comma, ind: self.characters.count - 3)
                newString = newString.insert(comma, ind: self.characters.count - 6)
                newString = newString.insert(comma, ind: self.characters.count - 9)

            }
        }
        magnitude()
        return newString
    }

}



