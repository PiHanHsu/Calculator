//
//  ViewController.swift
//  Calculator
//
//  Created by PiHan on 2017/9/11.
//  Copyright © 2017年 PiHan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //TODO: adjust layout on iPad

    // MARK: Labels Outlet
    @IBOutlet weak var chineseNumberLabel: UILabel!
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var pendingOperationLabel: UILabel!
    
    //MARKS: local variables

    private var inputString: String {
        get{
            var charArray = Array(displayLabel.text!)
            charArray = charArray.filter({$0 != ","})
            return String(charArray)
        }
        set{
            if let number = Double(newValue){
                displayValue = number
            }else{
                displayLabel.text = inputString
            }
        }
    }
    
    private var displayChars: Array<Character> {
        get {
            return Array(inputString)
        }
        set {
            inputString = String(newValue)
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
            return formatStringToNumber(inputString)!
        }
        set {
            displayLabel.text = formatNumberToString(newValue)
            chineseNumberString = translation.translate(from: newValue)
        }
    }
    
    var chineseNumberString: String {
        get {
            return chineseNumberLabel.text!
        }
        set {
            chineseNumberLabel.text = newValue
        }
    }
    
    private var brain = CalculatorBrain()
    private var useIsTyping = false
    private var hasDot = false
    
    private var translation = Translation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reset()
    }
    
    // MARK: IBActions
    @IBAction func numberPressed(_ sender: UIButton) {
        
        if useIsTyping{
            guard displayChars.count < 16 else {
                return
            }
            if sender.currentTitle == "." {
                if hasDot {
                    return
                }else{
                    hasDot = true
                    displayLabel.text = displayLabel.text! + "."
                }
            }
            inputString += sender.currentTitle!
            chineseNumberString = translation.translate(from: displayValue)
         
        }else{
            if sender.currentTitle == "." {
                if hasDot {
                    return
                }else{
                    hasDot = true
                    displayLabel.text = "0."
                }
            }else{
                inputString = sender.currentTitle!
            }
            
            useIsTyping = true
        }
    }
    
    @IBAction func performOperation(_ sender: UIButton) {
        
        if useIsTyping{
            brain.setOperand(displayValue)
            useIsTyping = false
            hasDot = false
        }
        if let mathSymbol = sender.currentTitle{
            brain.performOperation(mathSymbol)
        }
        
        if let result = brain.result {
            guard !brain.calculateError else{
                displayError()
                return
            }
            displayValue = result
        }
        
        if let number = brain.lefthandValue {
            
            if number.truncatingRemainder(dividingBy: 1) == 0 {
                if sender.currentTitle! == "=" || sender.currentTitle! == "-/+"{
                     pendingOpeationString = String(Int(number))
                }else{
                    pendingOpeationString = String(Int(number)) + sender.currentTitle!
                }
            }else{
                if sender.currentTitle! == "=" || sender.currentTitle! == "%" || sender.currentTitle! == "-/+"{
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
    
    func displayError() {
        brain = CalculatorBrain()
        displayLabel.text = "無法計算"
        hasDot = false
        pendingOpeationString = " "
        chineseNumberString = " "
    }
    
    @IBAction func resetCalculator(_ sender: UIButton) {
        brain = CalculatorBrain()
        displayLabel.text = "0"
        hasDot = false
        pendingOpeationString = " "
        chineseNumberString = " "
        useIsTyping = false
    }
    
    func reset() {
        brain = CalculatorBrain()
        displayLabel.text = "0"
        hasDot = false
        pendingOpeationString = " "
        chineseNumberString = " "
        useIsTyping = false
    }
    
    
    // formating number
    
    func formatNumberToString(_ number: Double) -> String{
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        numberFormatter.maximumFractionDigits = 15
        let formattedNumberString = numberFormatter.string(from: NSNumber(value:number))
        return formattedNumberString!
    }
    
    func formatStringToNumber(_ string: String) -> Double?{
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        if let number = formatter.number(from: string) {
            let doubleNumber = number.doubleValue
            return doubleNumber
        }
       
        return nil
    }
}

