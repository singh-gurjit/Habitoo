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
    
    func arrayToString (array: [Int]) -> String {
        let array = array
        let arrayToStringArray = array.map { String($0) }
        let convertArrayToString = arrayToStringArray.joined(separator: ",")
        return convertArrayToString
    }
    
}
