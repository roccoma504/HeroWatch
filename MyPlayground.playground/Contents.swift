//: Playground - noun: a place where people can play

import UIKit

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
        }
        magnitude()
        return newString
    }
}

var test : String = "10000000"

let yo = test.addComma()

