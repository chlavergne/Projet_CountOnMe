//
//  CountOnMeTests.swift
//  CountOnMeTests
//
//  Created by Christophe Expleo on 03/06/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import XCTest

@testable import CountOnMe

class CalculatorTest: XCTestCase {

    var calculator: Calculator!

    // Methode setUp permet de faire une initialisation
    override func setUp() {
        super.setUp()
        calculator = Calculator()
    }

    func createAnAddition() {
        calculator.addNumber(number: "3")
        calculator.addOperator(operatorSymbol: "+")
        calculator.addNumber(number: "7")
    }

    func testGivenExpressionHaveAResult_WhenAddNumber_ThenEquationIsAnEmptySring() {
        createAnAddition()
        calculator.addEqual()
        calculator.addNumber(number: "3")
        XCTAssertEqual(calculator.equation, "3")
    }

    func testGivenExpressionIsFinishingByAnOperator_WhenaddAnOperator_ThenErrorMessage() {
        createAnAddition()
        calculator.addOperator(operatorSymbol: "+")
        calculator.addOperator(operatorSymbol: "÷")
        XCTAssertTrue(calculator.equation == "3 + 7 + ")
    }

    func testGivenExpressionIsEndingByOperator_WhenAddEqual_ThenErrorMessage() {
        createAnAddition()
        calculator.addOperator(operatorSymbol: "-")
        calculator.addEqual()
        XCTAssertTrue(calculator.equation.firstIndex(of: "=") == nil)
    }

    func testGivenExpressionHasnotEnoughElements_WhenAddEqual_ThenErrorMessage() {
        calculator.addNumber(number: "3")
        calculator.addEqual()
        XCTAssertTrue(calculator.equation.firstIndex(of: "=") == nil)
        createAnAddition()
        calculator.addEqual()
        XCTAssertTrue(calculator.equation.firstIndex(of: "=") != nil)
    }

    func testGivenExpressionIsAnAddition_WhenAddAMultiplication_ThenMultiplicationIsCalculatedFirst() {
        createAnAddition()
        calculator.addOperator(operatorSymbol: "x")
        calculator.addNumber(number: "2")
        calculator.addEqual()
        XCTAssertTrue(calculator.equation == "3 + 7 x 2 = 17")
    }

    func testGivenExpressionIsADivision_WhenAddAMultiplication_ThenDivisionIsCalculatedFirst() {
        calculator.addNumber(number: "4")
        calculator.addOperator(operatorSymbol: "÷")
        calculator.addNumber(number: "2")
        calculator.addOperator(operatorSymbol: "x")
        calculator.addNumber(number: "5")
        calculator.addEqual()
        XCTAssertTrue(calculator.equation == "4 ÷ 2 x 5 = 10")
    }

    func testGivenExpressionIsADivision_WhenRightElementIsZero_ThenErrorMessage() {
        calculator.addNumber(number: "4")
        calculator.addOperator(operatorSymbol: "÷")
        calculator.addNumber(number: "0")
        calculator.addEqual()
        XCTAssertTrue(calculator.equation == " Error  = inf")
    }

    func testGivenAnExpressionExist_WhenTappedACButton_ThenEquationShouldBeEmpty() {
        createAnAddition()
        calculator.addAC()
        XCTAssertTrue(calculator.equation == "")
    }
}
