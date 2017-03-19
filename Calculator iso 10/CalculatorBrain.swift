//
//  CalculatorBrain.swift
//  Calculator iso 10
//
//  Created by yanyin on 19/03/2017.
//  Copyright © 2017 yanyin. All rights reserved.
//

import Foundation

struct CalculatorBrain {
    
    private var accumulator: Double?
    private var resultIsPending: Bool = false
    
    private enum Operation: CustomStringConvertible {
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double,Double) -> Double)
        case equals
        var description: String {
            get {
                switch self {
                case .constant(let value):
                    return ""
                case .UnaryOperation(let function):
                    return ""
                case .BinaryOperation(let function):
                    return ""
                }
            }
        }
    }
    
    private var operations: Dictionary<String, Operation> = [
        "π": Operation.constant(Double.pi),
        "√": Operation.unaryOperation(sqrt),
        "cos": Operation.unaryOperation(cos),
        "±": Operation.unaryOperation{ -$0 },
        "×": Operation.binaryOperation{ $0 * $1 },
        "÷": Operation.binaryOperation{ $0 / $01 },
        "+": Operation.binaryOperation{ $0 + $1 },
        "−": Operation.binaryOperation{ $0 - $1 },
        "=": Operation.equals
    ]
    
    mutating func performOperation(_ symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .constant(let value):
                resultIsPending = false
                accumulator = value
            case .unaryOperation(let function):
                resultIsPending = false
                if accumulator != nil {
                    accumulator = function(accumulator!)
                }
            case .binaryOperation(let function):
                resultIsPending = true
                if accumulator != nil {
                    pendingBinaryOperaion = PendingBinaryOperation(function: function, firstOperand: accumulator!)
                    accumulator = nil
                }
            case .equals:
                
                performBinaryOperation()
            }
        }
    }
    
    private struct PendingBinaryOperation {
        let function: (Double, Double) -> Double
        let firstOperand: Double
        func perform(with secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
        
    }
    
    private var pendingBinaryOperaion: PendingBinaryOperation?
    
    private mutating func performBinaryOperation() {
        if pendingBinaryOperaion != nil && accumulator != nil {
            accumulator = pendingBinaryOperaion?.perform(with: accumulator!)
            pendingBinaryOperaion = nil
        }
        
    }

    mutating func setOperand(_ operand: Double) {
        accumulator = operand
    }
    
    var result: Double? {
        get {
            return accumulator
        }
    }
}
