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
        case EndOne, EndTwo, EndThree, LabelOne, LabelTwo, LabelThree
    }
    
    private var valueOne, valueTwo, valueThree : Float!
    private var labelOne, labelTwo : String!
    private var angleOneEnd, angleTwoEnd : Int!
    private var angleThreeEnd : Int = 0
    private var labelThree : String = ""
    
    
    
    init (valueOne : String,
          valueTwo : String,
          valueThree : String = "0",
          labelOne : String,
          labelTwo : String,
          labelThree : String = "") {
        super.init()
        
        self.valueOne = Float(valueOne)
        self.valueTwo = Float(valueTwo)
        self.valueThree = Float(valueThree)
        self.labelOne = labelOne
        self.labelTwo = labelTwo
        self.labelThree = labelThree
        calculate(Float(valueOne)!, two: Float(valueTwo)!, three: Float(valueThree)!)
        calculate(labelOne, two:labelTwo, three: labelThree)

        
    }
    
    private func formatedString(title : String, value : Float) -> String {
    return title + " " + String(Int(value)).addComma()
    }
    
    private func newAngle(count : Float, max : Float) -> Int {
        return Int(360 * (count / max))
    }
    
    private func addArray (array : Array <Float>, start : Int, finish : Int) -> Float {
        let total = array[start...finish].reduce(0, combine: +)
        return total
    }
    
    private func calculate(one : Float, two: Float, three : Float) {
        
        let total = valueOne + valueTwo + valueThree
        var sortedArray : Array <Float> = []

        sortedArray.append(valueOne)
        sortedArray.append(valueTwo)
        sortedArray.append(valueThree)
        sortedArray = sortedArray.sort()
        
        angleThreeEnd = newAngle(addArray(sortedArray, start: 0, finish: 2), max: total)
        angleTwoEnd = newAngle(addArray(sortedArray, start: 1, finish: 2), max: total)
        angleOneEnd = newAngle(addArray(sortedArray, start: 2, finish: 2), max: total)
        
    }
    
    private func calculate (one : String, two: String, three : String) {
        
        labelOne = formatedString(one, value: valueOne)
        labelTwo = formatedString(two, value: valueTwo)
        labelThree = formatedString(three, value: valueThree)

    }
    
    func get (value : Param) -> Int {
        switch value {
        case .EndOne:
            return angleOneEnd
        case .EndTwo:
            return angleTwoEnd
        case .EndThree:
            return angleThreeEnd
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
        default :
            return "error"
        }
    }
    
}
