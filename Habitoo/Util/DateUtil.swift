//
//  DateUtil.swift
//  Habitoo
//
//  Created by Gurjit Singh on 15/05/20.
//  Copyright © 2020 Gurjit Singh. All rights reserved.
//

import Foundation
import SwiftUI

class DateUtil {
    
    var date = Date()
    let formatter = DateFormatter()
    
    //returns current day
     func getCurrentDay() -> String {
        
        formatter.dateFormat = "d"
        return formatter.string(from: date)
    }
    
    //returns arrays of current week days
    func currentWeekDays () -> [String] {
        let calendar = Calendar.current
        formatter.dateFormat = "d"
        let dayOfWeek = calendar.component(.weekday, from: date)
        let weekdays = calendar.range(of: .weekday, in: .weekOfYear, for: date)!
        let days = (weekdays.lowerBound ..< weekdays.upperBound)
            .compactMap { calendar.date(byAdding: .day, value: $0 - dayOfWeek, to: date) }
        //print(days)
        let dateObjects = days.compactMap { formatter.string(from: $0) }
        return dateObjects
    }
}
