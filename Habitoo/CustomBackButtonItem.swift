//
//  File.swift
//  Habitoo
//
//  Created by Gurjit Singh on 14/05/20.
//  Copyright © 2020 Gurjit Singh. All rights reserved.
//

import Foundation
import SwiftUI

struct CustomBackButtonItem: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }){
            HStack {
                Image(systemName: "chevron.left").imageScale(.medium).font(Font.headline.weight(.semibold)).foregroundColor(Color.red)
                Text("").font(.headline).fontWeight(.semibold).foregroundColor(Color.red)
            }
        }
    }
}
