//
//  MetricsThisYear.swift
//  Habitoo
//
//  Created by Gurjit Singh on 08/07/20.
//  Copyright © 2020 Gurjit Singh. All rights reserved.
//

import SwiftUI

struct MetricsThisYear: View {
    
    private var completeDataBaseUtil = CompleteDatabaseUtil()
    var months = ["January","February","March","April","May","June","July","August","September","October","November","December"]
    
    var monthsOfYear = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]
    
    var body: some View {
            
        HStack {
            VStack {
            Text("100")
                .font(.footnote)
                .frame(height: 10)
            Rectangle()
            .fill(Color.gray)
            .frame(width: 1, height: CGFloat(5) * 15.0)
                .opacity(0.5)
                Text("50")
                .font(.footnote)
                .frame(height: 10)
                Rectangle()
                .fill(Color.gray)
                .frame(width: 1, height: CGFloat(5) * 15.0)
                    .opacity(0.5)
                Text("0")
                .font(.footnote)
                .frame(height: 10)
            }
            
          ForEach(0..<12) { month in
            VStack {
              Spacer()
                HStack(alignment: .bottom, spacing: 0) {
              Rectangle()
                .fill(Color.orange)
                .frame(width: 10, height: CGFloat(self.completeDataBaseUtil.calculatePercentageThisYearHabit(month: month)) * 18.0)
                Rectangle()
                .fill(Color.green)
                .frame(width: 10, height: CGFloat(self.completeDataBaseUtil.calculatePercentageThisYearTask(month: month)) * 18.0)
                }
                Text("\(month + 1)")
                .font(.footnote)
                .frame(height: 10)
            }
          }
        }
    }
}
