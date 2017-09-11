//
//  ViewController.swift
//  Calculator
//
//  Created by PiHan on 2017/9/11.
//  Copyright © 2017年 PiHan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: Labels Outlet
    @IBOutlet weak var chineseNumberLabel: UILabel!
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var pendingOperationLabel: UILabel!
    
    //MARKS: local variables
    private var displayString: String {
        get{
            return displayLabel.text!
        }
        set {
            displayLabel.text = newValue
        }
    }
    
    private var displayChars: Array<Character> {
        get {
            return Array(displayString)
        }
        set {
            displayString = String(newValue)
            
        }
    }
    
    private var pendingOpeationString: String {
        get {
            return pendingOperationLabel.text!
        }
        set {
            pendingOperationLabel.text = newValue
        }
    }
    
    var displayValue: Double{
        get {
            return Double(displayString)!
        }
        set {
            displayString = String(newValue)
            chineseNumberLabel.text = translation.translate(from: newValue)
        }
    }
    
    private var brain = CalculatorBrain()
    private var useIsTyping = false
    private var hasDot = false
    
    private var translation = Translation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: IBActions
    @IBAction func numberPressed(_ sender: UIButton) {
        if useIsTyping{
            if sender.currentTitle == "." {
                if hasDot {
                    return
                }else{
                    hasDot = true
                }
            }
            
            if (displayChars[0] == "0" && displayChars.count == 1){
                if(sender.currentTitle == "."){
                    displayString += sender.currentTitle!
                    hasDot = true
                }else{
                    displayString = sender.currentTitle!
                }
            }else{
                displayString += sender.currentTitle!
                chineseNumberLabel.text = translation.translate(from: displayValue)
            }
        }else{
            displayString = sender.currentTitle!
            useIsTyping = true
        }
        
    }
    
    @IBAction func performOperation(_ sender: UIButton) {
        if useIsTyping{
            brain.setOperand(displayValue)
            useIsTyping = false
        }
        if let mathSymbol = sender.currentTitle{
            brain.performOperation(mathSymbol)
        }
        
        if let result = brain.result {
            displayValue = result
            if result.truncatingRemainder(dividingBy: 1) == 0 {
                displayString = String(Int(result))
            }else{
                displayString = String(result)
            }
        }
        
        if let number = brain.lefthandValue {
            
            if number.truncatingRemainder(dividingBy: 1) == 0 {
                if sender.currentTitle! == "=" || sender.currentTitle! == "-/+"{
                     pendingOpeationString = String(Int(number))
                }else{
                    pendingOpeationString = String(Int(number)) + sender.currentTitle!
                }
            }else{
                if sender.currentTitle! != "=" || sender.currentTitle! == "%" || sender.currentTitle! == "-/+"{
                    pendingOpeationString = String(number)
                }else{
                    pendingOpeationString = String(number) + sender.currentTitle!
                }
            }
        }
        
    }
    
    @IBAction func backspacePressed(_ sender: Any) {
        if useIsTyping{
            if displayChars.count == 1 {
                displayChars[0] = "0"
            }else{
                displayChars.removeLast()
            }
        }
       
    }
    
    @IBAction func resetCalculator(_ sender: UIButton) {
        brain = CalculatorBrain()
        displayString = "0"
        hasDot = false
        pendingOpeationString = " "
        
    }
    

}

