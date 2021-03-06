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

let colors = [FlatMint(),FlatPurple(),FlatPink()]


let OFFENSE_HEROES = ["Genji","Mccree","Pharah","Reaper","Soldier 76","Tracer"]
let DEFENSE_HEROES = ["Bastion","Hanzo","Junkrat","Mei","Torbjorn","Widowmaker"]
let TANK_HEROES = ["D.Va","Reinhardt","Roadhog","Winston","Zarya"]
let SUPPORT_HEROES = ["Ana","Lucio","Mercy","Symmetra","Zenyatta"]


let heroImageMap = ["Soldier 76":"soldier_76.png",
                    "Hanzo":"hanzo.png",
                    "Pharah":"pharah.png",
                    "Genji":"genji.png",
                    "Tracer":"tracer.png",
                    "Widowmaker":"widowmaker.png",
                    "Bastion":"bastion.png",
                    "D.Va":"dva.png",
                    "Torbjorn":"torbjorn.png",
                    "Zenyatta":"zenyatta.png",
                    "Mccree":"mcree.png",
                    "Mercy":"mercy.png",
                    "Roadhog":"roadhog.png",
                    "Reaper":"reaper.png",
                    "Symmetra":"symmetra.png",
                    "Lucio":"lucio.png",
                    "Junkrat":"junkrat.png",
                    "Mei":"mei.png",
                    "Winston":"winston.png",
                    "Zarya":"zarya.png",
                    "Reinhardt":"reinhardt.png",
                    "Ana":"ana.png"]

enum StatKind : String {
    case Quick = "QP"
    case Competitive = "CP"
}


extension String {
    private func replace(string:String, replacement:String) -> String {
        return self.stringByReplacingOccurrencesOfString(string, withString: replacement, options: NSStringCompareOptions.LiteralSearch, range: nil)
    }
    
    func removeWhitespace() -> String {
        return self.replace(" ", replacement: "")
    }
    
    func replaceHash() -> String {
        return self.replace("#", replacement: "-")
    }
    func replaceDash() -> String {
        return self.replace("-", replacement: " ")
    }
    
    func removeColon() -> String {
        return self.replace(":", replacement: "")
    }
    
    func removeComma() -> String {
        return self.replace(",", replacement: "")
    }
    
    func replaceWords() -> String {
        return self.replace("Mostin", replacement: "Most In")
    }
    
    
    
    func replaceHeroes() -> String {
        let badHeroNames = ["Soldier 76","Torbjorn","D.Va"]
        let fixedHeroesName = ["Soldier76","Torbjoern","DVa"]
        
        if badHeroNames.contains(self) {
            return fixedHeroesName[badHeroNames.indexOf(self)!]
        }
        else {
            return self
        }
    }
    
    
    var removeExcessiveSpaces: String {
        let components = self.componentsSeparatedByCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        let filtered = components.filter({!$0.isEmpty})
        return filtered.joinWithSeparator("  ")
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
    
    func replaceUpper() -> String {
        
        var result = ""
        var characters = Array(self.characters)
        result += String(characters[0])
        for i in 1 ..< characters.count {
            let s = String(characters[i])
            if s == s.uppercaseString {
                result += " "
                result += s.uppercaseString
            } else {
                result += s.lowercaseString
            }
        }
        return result
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

extension UIImage {
    var circle: UIImage {
        let square = size.width < size.height ? CGSize(width: size.width, height: size.width) : CGSize(width: size.height, height: size.height)
        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: square))
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        imageView.image = self
        imageView.layer.cornerRadius = square.width/2
        imageView.layer.masksToBounds = true
        UIGraphicsBeginImageContext(imageView.bounds.size)
        imageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
}



