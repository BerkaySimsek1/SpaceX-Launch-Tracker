//
//  LearnMoreView.swift
//  SpaceX Launch Tracker
//
//  Created by Berkay on 23.06.2023.
//

import SwiftUI


func learnMoreView(_ link: String?) -> some View {
    Text("Learn more").font(.system(size: 15))
        .padding(.all, 3)
        .background(Color(hex: 0xff70a9a1))
        .foregroundColor(.white)
        .cornerRadius(10)
        .onTapGesture {
            // Takes the page
            guard let url = URL(string: link!) else { return }
            UIApplication.shared.open(url)
        }
}
