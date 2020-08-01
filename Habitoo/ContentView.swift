//
//  ContentView.swift
//  Habitoo
//
//  Created by Gurjit Singh on 13/05/20.
//  Copyright © 2020 Gurjit Singh. All rights reserved.
//

import SwiftUI
import Foundation

struct ContentView: View {
    
    @ObservedObject var viewNavigation = ViewNav()
    @State var isAddNewHabbitShown = false
    @State var isDashboardShowing = true
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                if self.viewNavigation.currentVisibleView == "home" {
                    //DashboardView()
                    Dash()
                } else if self.viewNavigation.currentVisibleView == "metrics" {
                    MetricsView()
                }
                Spacer()
                HStack {
                    //Dashboard
                    
                    if self.isDashboardShowing {
                        Image(systemName: "house.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(20)
                            .frame(width: geometry.size.width/3, height: 65)
                            .foregroundColor(Color.orange)
                            .onTapGesture {
                                self.viewNavigation.currentVisibleView = "home"
                                self.isDashboardShowing.toggle()
                        }
                    } else {
                        Image(systemName: "house.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(20)
                            .frame(width: geometry.size.width/3, height: 65)
                            .foregroundColor(Color.gray)
                            .onTapGesture {
                                self.viewNavigation.currentVisibleView = "home"
                                self.isDashboardShowing.toggle()
                        }
                    }
                    
                    //Add
                    ZStack {
                        Circle()
                            .foregroundColor(Color.white)
                            .frame(width: 70, height: 70)
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 70, height: 70)
                            .foregroundColor(Color.orange)
                            .onTapGesture {
                                self.isAddNewHabbitShown.toggle()
                        }
                        .sheet(isPresented: self.$isAddNewHabbitShown) {
                            NewHabitView()
                        }
                    } .offset(y: -geometry.size.height/10/2)
                    //Metrics
                    if !self.isDashboardShowing {
                        Image(systemName: "chart.pie.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(20)
                            .frame(width: geometry.size.width/3, height: 65)
                            .foregroundColor(Color.orange)
                            .onTapGesture {
                                self.viewNavigation.currentVisibleView = "metrics"
                                self.isDashboardShowing.toggle()
                        }
                    } else {
                        Image(systemName: "chart.pie.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(20)
                            .frame(width: geometry.size.width/3, height: 65)
                            .foregroundColor(Color.gray)
                            .onTapGesture {
                                self.viewNavigation.currentVisibleView = "metrics"
                                self.isDashboardShowing.toggle()
                        }
                    }
                    
                }.frame(width: geometry.size.width, height: geometry.size.height/10)
                    .background(Color.white.shadow(color: .orange,radius: 2))
            }.edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
