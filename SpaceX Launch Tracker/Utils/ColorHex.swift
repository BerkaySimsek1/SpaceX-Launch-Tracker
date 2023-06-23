//
//  ColorHex.swift
//  SpaceX Launch Tracker
//
//  Created by Berkay on 23.06.2023.
//

import SwiftUI


// Use colors with hex code
extension Color {
    init(hex: UInt32) {
        let red = Double((hex >> 16) & 0xFF) / 255.0
        let green = Double((hex >> 8) & 0xFF) / 255.0
        let blue = Double(hex & 0xFF) / 255.0

        self.init(red: red, green: green, blue: blue)
    }
}
