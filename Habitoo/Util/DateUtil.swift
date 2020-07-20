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
    var collectionUtil = CollectionUtil()
    let formatter = DateFormatter()
    let formatterCurrentMonth = DateFormatter()
    let formatterCurrentYear = DateFormatter()
    var currentMonth = ""
    var currentYear = ""
    var arrayToReturn = [String]()
    var months = ["January","February","March","April","May","June","July","August","September","October","November","December"]
    
    //returns current day
     func getCurrentDay() -> String {
        formatter.dateFormat = "d"
        return formatter.string(from: date)
    }
    
    func getCurrentMonth() -> String {
           formatter.dateFormat = "LLLL"
           //let convertStringToInt = collectionUtil.stringToInt(string: formatter.string(from: date))
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
    
    func filterDateFromCurrentMonth(array: [Date]) -> [String] {
        //get current month and year
        formatterCurrentMonth.dateFormat = "MM"
        currentMonth = formatterCurrentMonth.string(from: date)
        formatterCurrentYear.dateFormat = "yyyy"
        currentYear = formatterCurrentYear.string(from: date)
        arrayToReturn.removeAll()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateObjects = array.map{ formatter.string(from: $0) }
        for object in dateObjects {
            let splitArray = object.components(separatedBy: "-")
            if splitArray[0] == currentYear && splitArray[1] == currentMonth {
                //remove 0 from leading of string
                let numberToInt = Int(splitArray[2])
                arrayToReturn.append("\(numberToInt!)")
            }
        }
        return arrayToReturn
    }
    
    //change date format
    func dateFormatDay(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        let stringDate = formatter.string(from: date)
        //let date = formatter.date(from: stringDate)
        return stringDate
    }
    
}
