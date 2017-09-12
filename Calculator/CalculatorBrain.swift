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
    var hasPerformOperation = false
    var calculateError = false
    var result: Double? {
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
        "/" : .binary({$0 / $1}),
        "=" : .equals
    ]
    
    mutating func setOperand(_ operand: Double){
        if lefthandValue == nil {
            lefthandValue = operand
        }else{
            righthandValue = operand
            hasPerformOperation = false
        }
    }
    
    private struct PendingBinaryOperation {
        var firstOperand: Double?
        var opeartionFunction: (Double, Double) -> Double
        
        func perfromPendingOperation(with secondOperand: Double) -> Double{
            return opeartionFunction(firstOperand!, secondOperand)
        }
    }
    
    private var pbo: PendingBinaryOperation?
    
    mutating func performOperation(_ symbol: String){
        if let operation = operations[symbol]{
            calculateError = false
            switch operation {
            case .unary(let unaryFunction):
                if lefthandValue != nil {
                    lefthandValue = unaryFunction(lefthandValue!)
                }
            case .binary(let binaryFunction):
                if !hasPerformOperation{
                    performPendingOperation()
                }
                
                if lefthandValue != nil {
                    pbo = PendingBinaryOperation(firstOperand: lefthandValue, opeartionFunction: binaryFunction)
                }
            case .equals:
                performPendingOperation()
            }
        }
    }
    
    mutating func performPendingOperation(){
        if lefthandValue != nil && righthandValue != nil {
            lefthandValue = pbo?.perfromPendingOperation(with: righthandValue!)
            if let value = lefthandValue{
                if value >= 1e+16 || value <= -1e+16{
                    lefthandValue = 0
                    calculateError = true
                }else{
                    pbo?.firstOperand = value
                }
            }
           
            hasPerformOperation = true
        }
    }
    
}
