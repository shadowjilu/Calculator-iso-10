//
//  ViewController.swift
//  Calculator iso 10
//
//  Created by yanyin on 18/03/2017.
//  Copyright © 2017 yanyin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var userIsInMiiddleOfTyping = false
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        
        if userIsInMiiddleOfTyping {
            if (display.text!.contains(".") && digit != ".") || !display.text!.contains(".") {
                    let textCurrentlyInDisplay = display.text!
                    display.text = textCurrentlyInDisplay + digit
            }  
        } else {
                if digit == "." {
                    display.text = "0" + digit
                } else {
                    display.text = digit
                }
            userIsInMiiddleOfTyping = true
        }
        print("\(digit) was touched")
    }

    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    private var brain = CalculatorBrain()
    
    @IBAction func performOperation(_ sender: UIButton) {
        if userIsInMiiddleOfTyping {
            brain.setOperand(displayValue)
            userIsInMiiddleOfTyping = false
        }
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(mathematicalSymbol)
        }
        if let result = brain.result {
            displayValue = result
        }
        
    }
   
}

