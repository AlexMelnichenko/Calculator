//
//  Model.swift
//  GarwardCalculator
//
//  Created by Alex Skigenok on 18.04.17.
//  Copyright © 2017 AlexAlexAlex. All rights reserved.
//

import Foundation

struct CalculatorBrain{
    
    private var accomulator: Double?
    
    private enum Operation {
        case constant(Double)
        case unaryOperation((Double) -> Double)
                    // вот где $0       $1
        case binaryOperation((Double, Double) -> Double)
        case equals
    }
    
    private let operation: Dictionary<String,Operation> = [
        "π": Operation.constant(M_PI),
        "e": Operation.constant(M_E),
        "√": Operation.unaryOperation(sqrt),
        "cos": Operation.unaryOperation(cos),
        "±": Operation.unaryOperation({ -$0 }),
        "×": Operation.binaryOperation({ $0 * $1 }),
        "+": Operation.binaryOperation({ $0 + $1 }),
        "-": Operation.binaryOperation({ $0 - $1 }),
        "÷": Operation.binaryOperation({ $0 / $1 }),
        "=": Operation.equals
    ]

    
    
    
    //выполнать операцию
    mutating func performOperation (simbol: String){
        if let operation = operation[simbol]{
            switch operation {
            case .constant(let value):
                accomulator = value
            case .unaryOperation(let function):
                if accomulator != nil{
                    accomulator = function(accomulator!)
                }
            case .binaryOperation(let function):
                if accomulator != nil {
                    pendinBinaryOperation = PendingBinaryOperation(function: function, firsOperand: accomulator!)
                    accomulator = nil
                }
             case .equals:
                performPendingBinaryOperation()
            }
        }
    }
    
    private mutating  func performPendingBinaryOperation(){
        if pendinBinaryOperation != nil && accomulator != nil{
            accomulator = pendinBinaryOperation!.perfom(with: accomulator!)
            pendinBinaryOperation = nil
        }
    }
    
    private var pendinBinaryOperation:  PendingBinaryOperation?
    
    //в ожидании бинарной операции
    
    private struct PendingBinaryOperation {
        let function: (Double,Double) -> Double
        let firsOperand: Double
        
        func perfom(with secondOperand: Double) -> Double{
            return function(firsOperand,secondOperand)
        }
    }
    
    //набор операндов
    mutating func setOperand ( _ operand: Double){
        accomulator = operand
    }
    
    var resolt: Double? {
        get{
            return accomulator
            
        }
    }
    
}






























