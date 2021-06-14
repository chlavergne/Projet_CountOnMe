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
    
    private lazy var numberFormatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.maximumFractionDigits = 2
            formatter.minimumIntegerDigits = 0
            formatter.groupingSeparator = ""
            return formatter
        }()

    init() {
        equation = ""
    }

    // Create an array with all the elements in the equation string
    private var elements: [String] {
        return equation.split(separator: " ").map { "\($0)" }
    }

    private(set) var equation: String {
        didSet {
            textOnScreen?(equation)
        }
    }

    // Error check computed variables
    private var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "÷" && elements.last != "x"
    }

    private var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }

    private var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "÷" && elements.last != "x"
    }

    private var expressionHaveResult: Bool {
        return equation.firstIndex(of: "=") != nil
    }

    //  Entering the equation to be calculated
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

        // Iterate over operations while an operand still here and remove previous calcul if needed
        while operationsToReduce.count > 1 {
            if let index = operationsToReduce.firstIndex(where: { $0 == "x" || $0 == "÷" }) {
                let left = Double(operationsToReduce[index - 1])!
                let operand = operationsToReduce[index]
                let right = Double(operationsToReduce[index + 1])!
                let result = operandSelect(left, operand, right)
                operationsToReduce[index] = numberFormatter.string(for: NSNumber(value: result)) ?? ""
                operationsToReduce.remove(at: index + 1)
                operationsToReduce.remove(at: index - 1)
            } else {
                let left = Double(operationsToReduce[0])!
                let operand = operationsToReduce[1]
                let right = Double(operationsToReduce[2])!
                operationsToReduce = Array(operationsToReduce.dropFirst(3))
                let resultToClean = operandSelect(left, operand, right)
                let finalResult = numberFormatter.string(for: NSNumber(value: resultToClean)) ?? ""
                operationsToReduce.insert(finalResult, at: 0)
            }
        }

        equation.append(" = \(operationsToReduce.first!)")
    }

    // Reset display to zero
    func addAC() {
        equation.removeAll()
        textOnScreen?("0")
    }

    private func operandSelect(_ left: Double, _ operand: String, _ right: Double) -> Double {
        let result: Double
        switch operand {
        case "+": result = left + right
        case "-": result = left - right
        case "x": result = left * right
        case "÷": result = left / right
            if right == 0 {
                equation.removeAll()
                equation.append(" Error ")
                errorMessage?("Division par zéro impossible !")
            }
        default: return 0.0
        }
        return result
    }
}
