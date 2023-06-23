//
//  SplashView.swift
//  SpaceX Launch Tracker
//
//  Created by Berkay on 16.06.2023.
//

import SwiftUI


struct SplashView: View {
    
    @State var isActive: Bool = false
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Constants.backgroundColor
            if self.isActive {
                ContentView()
            } else {
                Rectangle()
                    .background(Constants.backgroundColor)
                
                    
                Image("rocket2")
                    .resizable().background(Constants.backgroundColor)
                Text("SpaceX Launch Tracker").font(.custom("Lobster-Regular",size: 40)).foregroundColor(.white).frame(maxWidth: .infinity)
                
                    
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
        
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
