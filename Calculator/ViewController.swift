//
//  ViewController.swift
//  Calculator
//
//  Created by PiHan on 2017/9/11.
//  Copyright © 2017年 PiHan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // Labels Outlet
    @IBOutlet weak var chineseNumberLabel: UILabel!
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var pendingOperationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func numberPressed(_ sender: UIButton) {
    }
    
    
    @IBAction func performOperation(_ sender: UIButton) {
    }
    
    @IBAction func backspacePressed(_ sender: Any) {
    }
    
    @IBAction func resetCalculator(_ sender: UIButton) {
    }
    

}

