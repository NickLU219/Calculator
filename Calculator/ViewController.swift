//
//  ViewController.swift
//  Calculator
//
//  Created by 陆金龙 on 15/7/20.
//  Copyright (c) 2015年 Nick. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    var UserIsInTheMiddleOfInputANumber = false

    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if UserIsInTheMiddleOfInputANumber{
            display.text = display.text! + digit
        } else {
            display.text = digit
            UserIsInTheMiddleOfInputANumber = true
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if UserIsInTheMiddleOfInputANumber {
            enter()
        }
        switch operation {
        case "×" :performOperation2 { $0 * $1 }
        case "÷" :performOperation2 { $1 / $0 }
        case "+" :performOperation2 { $0 + $1 }
        case "−" :performOperation2 { $1 - $0 }
        case "√" :performOperation1 { sqrt($0) }
        default  :break
        }
    }
    
    func performOperation2(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(),operandStack.removeLast())
            enter()
        }
        
    }
    func performOperation1(operation: Double -> Double) {
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
        
    }
    
    

    var operandStack = Array<Double>()
    @IBAction func enter() {
        UserIsInTheMiddleOfInputANumber = false
        operandStack.append(displayValue)
        print("operandStack is \(operandStack)")
    }
    
    var displayValue: Double {
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
            display.text = "\(newValue)"
            UserIsInTheMiddleOfInputANumber = false
        }
    }
    
}

