//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let calculator = Calculator()
    
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        connectModel()
    }
    
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        calculator.addNumber(number: numberText)
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        calculator.addAddition()
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        calculator.addSoustraction()
    }
    
    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        calculator.addMultiplication()
    }
    
    @IBAction func tappedDivisionButton(_ sender: UIButton) {
        calculator.addDivision()
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        calculator.addEqual()
    }
    
    @IBAction func tappedAcButton(_ sender: UIButton) {
        calculator.addAC()
    }
    
    func errorMessage(message: String) -> Void {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return self.present(alertVC, animated: true, completion: nil)
    }
    
    func connectModel() {
        calculator.errorMessage = errorMessage
        calculator.textOnScreen = {textOnScreen in
            self.textView.text = textOnScreen
        }
    }
}

