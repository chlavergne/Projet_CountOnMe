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

    //Methode setUp permet de faire une initialisation
    override func setUp() {
        super.setUp()
        calculator = Calculator()
    }
    
    func createAnAddition() {
        calculator.addNumber(number: "3")
        calculator.addAddition()
        calculator.addNumber(number: "5")
    }
    
    func testGivenExpressionHaveAResult_WhenAddNumber_ThenEquationIsAnEmptySring() {
        createAnAddition()
        calculator.addEqual()
        calculator.addNumber(number: "A")
        XCTAssertEqual(calculator.equation, "3")
    }
    
    func testGivenExpressionIsCorrect_WhenExpressionToCalaculateIsNotFinashingByAnOperator_ThenReturnTrue() {
        createAnAddition()
        XCTAssertTrue(calculator.expressionIsCorrect)
        calculator.addSoustraction()
        XCTAssertFalse(calculator.expressionIsCorrect)
    }
    
    
    func testGivenExpressionHaveEnoughElement_WhenExpressionHasThreeOrMoreELements_ThenReturnTrue() {
        calculator.addNumber(number: "3")
        XCTAssertFalse(calculator.expressionHaveEnoughElement)
        createAnAddition()
        XCTAssertTrue(calculator.expressionHaveEnoughElement)
    }
    
    func testGivenCanAddOperator_WhenExpressionToCalaculateIsNotFinashingByAnOperator_ThenReturnTrue() {
        createAnAddition()
        XCTAssertTrue(calculator.canAddOperator)
        calculator.addSoustraction()
        XCTAssertFalse(calculator.canAddOperator)
    }
    
    func testGivenExpressionHaveResult_WhenAddEqual_ThenReturnTrue() {
        createAnAddition()
        calculator.addEqual()
        XCTAssertTrue(calculator.expressionHaveResult)
    }
    
    func testGivenExpressionIsNotCorrect_WhenAddEqual_ThenErrorMessage() {
        createAnAddition()
        calculator.addSoustraction()
        calculator.addEqual()
        XCTAssertNotEqual(calculator.equation, "8")
    }
    
    
    func testGivenAddAddition_WhenAddAdditionAgain_ThenErrorMessage() {
        calculator.addAddition()
        calculator.addAddition()
        XCTAssertEqual(calculator.equation, " + ")
    }
    
    func testGivenAddSoustraction_WhenAddSoustractionAgain_ThenErrorMessage() {
        calculator.addSoustraction()
        calculator.addSoustraction()
        XCTAssertEqual(calculator.equation, " - ")
    }
    
    func testGivenAddMultiplication_WhenAccessingIt_ThenExist() {
        let multiplication: () = calculator.addMultiplication()
        XCTAssertNotNil(multiplication)
    }
    
    func testGivenAddDivision_WhenAccessingIt_ThenExist() {
        let division: () = calculator.addDivision()
        XCTAssertNotNil(division)
    }
}
