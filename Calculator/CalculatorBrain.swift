//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by PiHan on 2017/9/11.
//  Copyright © 2017年 PiHan. All rights reserved.
//

import Foundation
struct CalculatorBrain {
    var lefthandValue: Double?
    var righthandValue: Double?
    var result: Double {
        get {
            if let number = lefthandValue{
                return number
            }else {
                return 0
            }
        }
    }
    
    enum Operation {
        case unary((Double)-> Double)
        case binary((Double, Double) -> Double)
        case equals
    }
    
    var operations: Dictionary<String, Operation> = [
        "-/+" : .unary({-$0}),
        "%" : .unary({$0 / 100}),
        "+" : .binary({$0 + $1}),
        "-" : .binary({$0 - $1}),
        "x" : .binary({$0 * $1}),
        "/" : .binary({$0 / $1})
    ]
    
    mutating func setOperand(_ operand: Double){
        if lefthandValue == nil {
            lefthandValue = operand
        }else{
            righthandValue = operand
        }
    }
    
    
}
