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
    
    private var hasDot = false
    var displayValue: Double{
        get {
            return Double(displayString)!
        }
        set {
            displayString = String(newValue)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: IBActions
    @IBAction func numberPressed(_ sender: UIButton) {
        
        
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
        }
    }
    
    @IBAction func performOperation(_ sender: UIButton) {
    }
    
    @IBAction func backspacePressed(_ sender: Any) {
        if displayChars.count == 1 {
            displayChars[0] = "0"
        }else{
            displayChars.removeLast()
        }
    }
    
    @IBAction func resetCalculator(_ sender: UIButton) {
        displayString = "0"
        hasDot = false
    }
    

}

