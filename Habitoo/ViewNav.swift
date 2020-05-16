//
//  ViewNav.swift
//  Habitoo
//
//  Created by Gurjit Singh on 13/05/20.
//  Copyright © 2020 Gurjit Singh. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class ViewNav: ObservableObject {
    @Published var currentVisibleView = "home"
}

