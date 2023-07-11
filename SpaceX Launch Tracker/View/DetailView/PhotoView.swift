//
//  photoView.swift
//  SpaceX Launch Tracker
//
//  Created by Berkay on 20.06.2023.
//

import SwiftUI

// Show photos
struct photoView : View {
    @State var launch: Launch
    @State var amount: Int
    @State private var currentIndex = 0
    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    var body: some View {
        if(amount != 0) {
            ScrollView(.horizontal) {
                ScrollViewReader { value in
                    LazyHStack {
                        ForEach(0..<launch.links.flickr.original.count, id: \.self) { i in
                            AsyncImage(url: URL(string: launch.links.flickr.original[i] )) {image in
                                image
                                    .resizable()
                                    .frame(width: Constants.screenSize.width * 0.9, height: Constants.screenSize.height/3,alignment: .leading)
                                    .cornerRadius(12)
                                    .padding(.horizontal,24)
                                    .scaledToFit()
                            } placeholder: {
                                ProgressView()
                            }.frame(width:Constants.screenSize.width)
                        }
                        
                        // Photos switching automatically
                        .onReceive(timer) { _ in
                            currentIndex = currentIndex < amount-1 ? currentIndex + 1 : 0
                            withAnimation{value.scrollTo(currentIndex)}
                        }
                    }
                }
                
                
            }
            .scrollDisabled(true)
            .frame(width: Constants.screenSize.width, height: Constants.screenSize.height/3)
            .padding(.top)
            
        }
        // Show how many photos are on the screen
        if(amount != 0) {Text("\(currentIndex+1)/\(amount)")}
    }
}
