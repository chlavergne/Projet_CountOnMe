//
//  Calculator.swift
//  CountOnMe
//
//  Created by Christophe Expleo on 31/05/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation

final class Calculator {
    
    var errorMessage: ((String) -> Void)?
    
    var textOnScreen: ((String) -> Void)?
    
    init() {
        equation = ""
    }
    
    private var elements: [String] {
        return equation.split(separator: " ").map { "\($0)" }
    }
    
    var equation : String {
        didSet {
            textOnScreen?(equation)
        }
    }
    
    // Error check computed variables
    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "÷" && elements.last != "x"
    }
    
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "÷" && elements.last != "x"
    }
    
    var expressionHaveResult: Bool {
        return equation.firstIndex(of: "=") != nil
    }
    
    func addNumber(number: String) {
        if expressionHaveResult {
            equation = ""
        }
        equation.append(number)
    }
    
    func addOperator(operatorSymbol: String) {
        if canAddOperator {
            equation.append(" \(operatorSymbol) " )
        } else {
            errorMessage?("Un opérateur est déjà mis !")
        }
    }
    
    func addAC() {
        equation.removeAll()
        textOnScreen?("0")
    }
    
    func operandSelect(left: Double, operand: String, right: Double) -> Double{
        let result: Double
        switch operand {
        case "+": result = left + right
        case "-": result = left - right
        case "x": result = left * right
        case "÷": result = left / right
            if right == 0 {
                errorMessage?("Division par zéro impossible !")
            }
        default: fatalError("Unknown operator !")
        }
        return result
    }
    
    func addEqual() {
        guard expressionIsCorrect else {
            errorMessage?("Entrez une expression correcte !")
            return
        }
        
        guard expressionHaveEnoughElement else {
            errorMessage?("Démarrez un nouveau calcul !")
            return
        }
        
        // Create local copy of operations
        var operationsToReduce = elements
        
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            if let index = operationsToReduce.firstIndex(where: { $0 == "x" || $0 == "÷" }) {
                let left = Double(operationsToReduce[index - 1])!
                let operand = operationsToReduce[index]
                let right = Double(operationsToReduce[index + 1])!
                operationsToReduce[index] = "\(operandSelect(left: left, operand: operand, right: right).clean)"
                operationsToReduce.remove(at: index + 1)
                operationsToReduce.remove(at: index - 1)
                
            } else {
                
                let left = Double(operationsToReduce[0])!
                let operand = operationsToReduce[1]
                let right = Double(operationsToReduce[2])!
                operationsToReduce = Array(operationsToReduce.dropFirst(3))
                let finalResult = operandSelect(left: left, operand: operand, right: right).clean
                operationsToReduce.insert("\(finalResult)", at: 0)
            }
        }
        
        equation.append(" = \(operationsToReduce.first!)")
    }
}
extension Double {
    var clean: String {
           return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
        }
}
