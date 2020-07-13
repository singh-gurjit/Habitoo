//
//  CollectionUtil.swift
//  Habitoo
//
//  Created by Gurjit Singh on 22/05/20.
//  Copyright © 2020 Gurjit Singh. All rights reserved.
//

import Foundation
import SwiftUI

class CollectionUtil {
    
    //change array to string
    func arrayToString (array: [Int]) -> String {
        let array = array
        let arrayToStringArray = array.map { String($0) }
        let convertArrayToString = arrayToStringArray.joined(separator: ",")
        return convertArrayToString
    }
    
    //change string from integer array
    func stringToIntArray(string: String) -> [Int] {
        let array = string.components(separatedBy: ",")
        let intArray = array.map { Int($0)!}
        return intArray
    }
    
    //change date format
    func dateFormat(date: Date) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "d-M-y"
        let stringDate = formatter.string(from: date)
        let date = formatter.date(from: stringDate)
        return date!
    }
    
    func calculateCompletionByWeek(completion: Int, total: Int) -> Int {
        if total == 0 {
            return 0
        } else {
            let calculate = ((completion * total) * 100) / (7 * total)
            return calculate
        }
        
    }
    
    func calculatePercentage(from: Int, total: Int) -> Int{
        if total == 0 {
            return 0
        } else {
            return (from * 100) / (total)
        }
    }
}
