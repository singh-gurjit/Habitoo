//
//  GridCalendar.swift
//  Habitoo
//
//  Created by Gurjit Singh on 14/05/20.
//  Copyright © 2020 Gurjit Singh. All rights reserved.
//

import SwiftUI

import Foundation
import SwiftUI
import CoreData

struct GridCalender: View {
    let rows = 5
    let columns = 7
    let days = ["SUN","MON","TUE","WED","THU","FRI","SAT"]
    var currentDate = 1
    @State var hiddenView = false
    var weeks = 0
    var items = [[Date]]()
    lazy var dateFormatter: DateFormatter = {
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    var date = Date()
    var habitID: UUID = UUID()
    var databaseUtil = CompleteDatabaseUtil()
    @State var fetchResultFromDatabase = [Any]()
    
    init(id: UUID) {
        self.habitID = id
        setCalendar()
    }
    var completeDate = [Date]()
    
    var body: some View {
        VStack {
            
            ForEach(0 ..< rows, id: \.self) { row in
                HStack(spacing: 15) {
                    ForEach(0 ..< self.columns, id: \.self) { column in
                        //self.content(row, column)
                        VStack {
                            Image(systemName: "\(self.configureCell(date: self.items[row][column])).circle").font(.largeTitle)
                            .foregroundColor(.gray)
                        }.onAppear(){
                            self.fetchResultFromDatabase = self.databaseUtil.habitRecordForThisMonth(hID: self.habitID)
                            print("\(self.fetchResultFromDatabase)")
                        }
                    }
                }.padding(10)
            }
        }.frame(maxWidth: .infinity)
    }
    
    var cell:(Int, Int) -> String = { row, col in
        let result: String
        
        result = "\((row * 7) + col).circle"
        
        return result
    }
    
    mutating func setCalendar() {
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
