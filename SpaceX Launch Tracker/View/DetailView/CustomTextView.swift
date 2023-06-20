//
//  CustomTextView.swift
//  SpaceX Launch Tracker
//
//  Created by Berkay on 20.06.2023.
//

import Foundation
import SwiftUI

// Custom textView with background
struct customTextView: View {
    var customText: String
    var customColor: Color
    var body: some View {
        Text(customText)
            .padding()
            .background(customColor.cornerRadius(10).overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 4))
            )
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding()
    }
}
