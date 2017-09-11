//
//  Translation.swift
//  Calculator
//
//  Created by PiHan on 2017/9/11.
//  Copyright © 2017年 PiHan. All rights reserved.
//

import Foundation
struct Translation {
    var chineseNumber: String?
    mutating func translate(from number: Double) -> String {
        let numberStr = String(Int(number))
        var charArray = Array(numberStr)
        
        if (charArray.count > 12) {
            charArray.insert("兆" , at: charArray.count - 12)
            charArray.insert("億" , at: charArray.count - 8)
            charArray.insert("萬" , at: charArray.count - 4)
        }else if (charArray.count > 8){
            charArray.insert("億" , at: charArray.count - 8)
            charArray.insert("萬" , at: charArray.count - 4)
        }else if (charArray.count > 4){
            charArray.insert("萬" , at: charArray.count - 4)
        }else{
            return " "
        }
        
        chineseNumber = String(charArray)
        
        return chineseNumber!
    }
}
