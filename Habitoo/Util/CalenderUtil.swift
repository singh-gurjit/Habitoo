//
//  CalenderUtil.swift
//  Habitoo
//
//  Created by Gurjit Singh on 26/06/20.
//  Copyright © 2020 Gurjit Singh. All rights reserved.

import Foundation
import SwiftUI

class CalenderUtil {
    var weeks = 0
    var items = [[Date]]()
    lazy var dateFormatter: DateFormatter = {
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    var date = Date()
    
    func setCalendar() {
        let cal = Calendar.current
        let components = (cal as NSCalendar).components([.month, .day,.weekday,.year], from: date)
        let year =  components.year
        let month = components.month
        //let months = dateFormatter.monthSymbols
        //let monthSymbol = (months![month!-1])
        //lblMonth.text = "\(monthSymbol) \(year!)"

        let weekRange = (cal as NSCalendar).range(of: .weekOfMonth, in: .month, for: date)
        //let dateRange = (cal as NSCalendar).range(of: .day, in: .month, for: date)
        weeks = weekRange.length
        //let totalDaysInMonth = dateRange.length

        let totalMonthList = weeks * 7
        var dates = [Date]()
        var firstDate = dateFormatter.date(from: "\(year!)-\(month!)-1")!
        let componentsFromFirstDate = (cal as NSCalendar).components([.month, .day,.weekday,.year], from: firstDate)
        firstDate = (cal as NSCalendar).date(byAdding: [.day], value: -(componentsFromFirstDate.weekday!-1), to: firstDate, options: [])!

        for _ in 1 ... totalMonthList {
            dates.append(firstDate)
            firstDate = (cal as NSCalendar).date(byAdding: [.day], value: +1, to: firstDate, options: [])!
        }
        let maxCol = 7
        let maxRow = weeks
        items.removeAll(keepingCapacity: false)
        var i = 0
       
        for _ in 0..<maxRow {
            var colItems = [Date]()
            for _ in 0..<maxCol {
                colItems.append(dates[i])
                i += 1
            }
            //print(colItems)
            items.append(colItems)
        }
       
    }
    
    func configureCell(date: Date) -> String {
        let cal = Calendar.current
        let components = (cal as NSCalendar).components([.day], from: date)
        let day = components.day!
        return String(day)
    }
}
