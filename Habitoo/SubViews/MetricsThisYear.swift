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
    
    var body: some View {
            
        VStack(alignment: .leading) {
          ForEach(0..<12) { month in
//            VStack {
//              Spacer()
//                HStack(alignment: .bottom, spacing: 0) {
//              Rectangle()
//                .fill(Color.orange)
//                .frame(width: 12, height: self.completeDataBaseUtil.calculatePercentageThisYearHabit(month: month) * 2.0)
//                Rectangle()
//                .fill(Color.green)
//                    .frame(width: 12, height: self.completeDataBaseUtil.calculatePercentageThisYearTask(month: month) * 2.0)
//                }
//                Text("\(self.months[month])")
//                .font(.footnote)
//                .frame(height: 20)
            HStack {
                Text("\(self.months[month])").font(.headline)
                Spacer()
                Text("\(self.completeDataBaseUtil.calculatePercentageThisYearHabit(month: month) + self.completeDataBaseUtil.calculatePercentageThisYearTask(month: month))%").font(.headline).foregroundColor(.orange)
            }
          }
        }
    }
}
