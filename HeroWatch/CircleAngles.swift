//
//  CircleAngles.swift
//  HeroWatch
//
//  Created by Matthew Rocco on 7/25/16.
//  Copyright © 2016 Matthew Rocco. All rights reserved.
//

import UIKit

class CircleAngles: NSObject {
    
    enum Param {
        case EndOne, EndTwo, EndThree, EndFour, LabelOne, LabelTwo, LabelThree, LabelFour, Total
    }
    
    private var valueOne, valueTwo, valueThree, valueFour : Float!
    private var labelOne, labelTwo : String!
    private var angleOneEnd, angleTwoEnd : Int!
    private var angleThreeEnd : Int = 0
    private var labelThree : String = ""
    private var angleFourEnd : Int = 0
    private var labelFour : String = ""
    private var total : Float = 0.0
    
    init (valueOne : String,
          valueTwo : String,
          valueThree : String = "0",
          valueFour: String = "0",
          labelOne : String,
          labelTwo : String,
          labelThree : String = "",
          labelFour : String = "") {
        super.init()
        
        self.valueOne = Float(valueOne)
        self.valueTwo = Float(valueTwo)
        self.valueThree = Float(valueThree)
        self.valueFour = Float(valueFour)
        
        self.labelOne = labelOne
        self.labelTwo = labelTwo
        self.labelThree = labelThree
        self.labelFour = labelFour
        
        calculate(Float(valueOne)!, two: Float(valueTwo)!, three: Float(valueThree)!, four: Float(valueFour)!)
        calculate(labelOne, two:labelTwo, three: labelThree, four: labelFour)
        
        
    }
    
    private func formatedString(title : String, value : Float, percentage: Float) -> String {
        return title + " " + String(Int(value)).addComma() + "/" + String(Int(percentage)) + "%"
    }
    
    private func newAngle(count : Float, max : Float) -> Int {
        return Int(360 * (count / max))
    }
    
    private func addArray (array : Array <Float>, start : Int, finish : Int) -> Float {
        let total = array[start...finish].reduce(0, combine: +)
        return total
    }
    
    private func calculate(one : Float, two: Float, three : Float, four : Float) {
        
        total = one + two + three + four
        var sortedArray : Array <Float> = []
        
        sortedArray.append(one)
        sortedArray.append(two)
        sortedArray.append(three)
        sortedArray.append(four)
        
        sortedArray = sortedArray.sort()
        
        print (sortedArray)
        
        angleFourEnd = newAngle(addArray(sortedArray, start: 0, finish: 3), max: total)
        angleThreeEnd = newAngle(addArray(sortedArray, start: 1, finish: 3), max: total)
        angleTwoEnd = newAngle(addArray(sortedArray, start: 2, finish: 3), max: total)
        angleOneEnd = newAngle(addArray(sortedArray, start: 3, finish: 3), max: total)
        print("4 "+String(angleFourEnd))
        print("3 "+String(angleThreeEnd))
        print("2 "+String(angleTwoEnd))
        print("3 "+String(angleOneEnd))

        
    }
    
    private func calculate (one : String, two: String, three : String, four : String) {
        
        labelOne = formatedString(one, value: valueOne, percentage: 100 * valueOne/total)
        labelTwo = formatedString(two, value: valueTwo, percentage: 100 * valueTwo/total)
        labelThree = formatedString(three, value: valueThree, percentage: 100 * valueThree/total)
        labelFour = formatedString(four, value: valueFour, percentage: 100 * valueFour/total)

        
    }
    
    func get (value : Param) -> Int {
        switch value {
        case .EndOne:
            return angleOneEnd
        case .EndTwo:
            return angleTwoEnd
        case .EndThree:
            return angleThreeEnd
        case .EndFour:
            return angleFourEnd
        case .Total:
            return Int(total)
        default:
            return -1
        }
    }
    
    func get (value : Param) -> String {
        switch value {
        case .LabelOne:
            return labelOne
        case .LabelTwo:
            return labelTwo
        case .LabelThree:
            return labelThree
        case .LabelFour:
            return labelFour
        default :
            return "error"
        }
    }
    
}
