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
        return elements.last != "+" && elements.last != "-"
    }
    
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-"
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
    
    func addAddition() {
        if canAddOperator {
            equation.append(" + ")
        } else {
            errorMessage?("Un opérateur est déjà mis !")
        }
    }
    
    func addSoustraction() {
        if canAddOperator {
            equation.append(" - ")
        } else {
            errorMessage?("Un opérateur est déjà mis !")
        }
    }
    
    func addMultiplication() {
        if canAddOperator {
            equation.append(" * ")
        } else {
            errorMessage?("Un opérateur est déjà mis !")
        }
    }
    
    func addDivision() {
        if canAddOperator {
            equation.append(" / ")
        } else {
            errorMessage?("Un opérateur est déjà mis !")
        }
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
            let left = Int(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Int(operationsToReduce[2])!
            
            let result: Int
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            default: fatalError("Unknown operator !")
            }
            
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result)", at: 0)
        }
        
        equation.append(" = \(operationsToReduce.first!)")
    }
}
