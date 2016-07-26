//
//  CircleAngles.swift
//  HeroWatch
//
//  Created by Matthew Rocco on 7/25/16.
//  Copyright © 2016 Matthew Rocco. All rights reserved.
//

import UIKit

class CircleAngles: NSObject {
    
    enum CircleAngles {
        case EndOne, EndTwo, EndThree
    }
    
    private var valueOne, valueTwo, valueThree : Float!
    private var angleOneEnd, angleTwoEnd : Int!
    private var angleThreeEnd : Int = 0

    
    init (valueOne : String,
          valueTwo : String,
          valueThree : String = "0") {
        super.init()
        
        self.valueOne = Float(valueOne)
        self.valueTwo = Float(valueTwo)
        self.valueThree = Float(valueThree)
        calculateAngles(Float(valueOne)!, valueTwo: Float(valueTwo)!, valueThree: Float(valueThree)!)
    }
    
    private func newAngle(count : Float, max : Float) -> Int {
        return Int(360 * (count / max))
    }
    
    private func addArray (array : Array <Float>, start : Int, finish : Int) -> Float {
        let total = array[start...finish].reduce(0, combine: +)
        return total
    }
    
    private func calculateAngles(valueOne : Float, valueTwo: Float, valueThree : Float) {
        
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
    
    func get (angle : CircleAngles) -> Int {
        switch angle {
        case .EndOne:
            return angleOneEnd
        case .EndTwo:
            return angleTwoEnd
        case .EndThree:
            return angleThreeEnd
        }
    }
    
}
