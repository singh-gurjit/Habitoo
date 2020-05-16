//
//  HabitDetailView.swift
//  Habitoo
//
//  Created by Gurjit Singh on 14/05/20.
//  Copyright © 2020 Gurjit Singh. All rights reserved.
//

import Foundation
import SwiftUI

struct HabitDetailView: View {
    
    let rows = 5
    let columns = 7
    @State var isEditHabbitShown = false
    
    var body: some View {
        List {
            VStack(alignment: .leading) {
                
                HStack {
                    Image(systemName: "chevron.left").foregroundColor(.orange)
                    .font(Font.title.weight(.semibold))
                    Spacer()
                    Text("Meditate in the morning").foregroundColor(.gray)
                    .font(.headline)
                    Spacer()
                     Image(systemName: "pencil").foregroundColor(.orange)
                        .font(Font.title.weight(.semibold))
                        .onTapGesture {
                            self.isEditHabbitShown.toggle()
                    }.sheet(isPresented: self.$isEditHabbitShown) {
                        EditHabitView()
                    }
                }.padding(EdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 0))
                
                Text("8 AM, Everyday").foregroundColor(.gray)
                    .font(.headline)
                Divider()
                HStack {
                    Text("Day").foregroundColor(.orange)
                    Spacer()
                    Text("Week").foregroundColor(.orange)
                    Spacer()
                    Text("Month").foregroundColor(.white)
                        .padding(8)
                        .background(Color.orange)
                        .cornerRadius(10)
                    Spacer()
                    Text("Year").foregroundColor(.orange)
                }.padding()
                
                VStack(alignment: .center) {
                    HStack(alignment: .center, spacing: 15) {
                        ForEach(0..<7, id: \.self) { index in
                            Text("S").frame(minWidth: 0, maxWidth: .infinity)
                                .font(.headline)
                        }
                    }
                    ForEach(0 ..< rows, id: \.self) { row in
                        HStack(alignment: .center, spacing: 15) {
                            ForEach(0 ..< self.columns, id: \.self) { column in
                                //self.content(row, column)
                                VStack {
                                    Image(systemName: "1.circle").font(.title)
                                        .frame(minWidth: 0, maxWidth: .infinity)
                                        .foregroundColor(.gray)
                                }
                            }
                        }.padding(10)
                    }
                }.padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.gray, lineWidth: 2)
                            .opacity(0.1)
                )
                
                VStack(spacing: 10) {
                    
                    ForEach(0..<7, id: \.self) { index in
                        VStack(alignment: .leading) {
                            Text("November, 20 - 23").padding()
                                .font(Font.headline.weight(.semibold))
                                .foregroundColor(.orange)
                            Text("You Have new record! As many as 4 days of stable training").padding()
                                .font(Font.headline.weight(.medium))
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
        }.listStyle(GroupedListStyle())
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .accentColor(Color.orange)
    }
}
