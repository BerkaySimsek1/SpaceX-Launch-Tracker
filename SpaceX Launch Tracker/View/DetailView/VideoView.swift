//
//  VideoView.swift
//  SpaceX Launch Tracker
//
//  Created by Berkay on 20.06.2023.
//

import Foundation
import SwiftUI
import WebKit
@ViewBuilder
func videoView(_ link: String?)-> some View{
    // Show video with embeded youtube screen
    if(link != nil){
        VStack(alignment: .leading){
            Text("Launch Video:").padding(.horizontal).fontWeight(.bold)
            EmbedView(videoLink: link!).frame(height: Constants.screenSize.height * 0.3,alignment: .leading)
                .cornerRadius(12)
                .padding(.horizontal,24)
        }.padding(.horizontal)
    }
}


// Make youtube screen embeded
struct EmbedView : UIViewRepresentable {
    let videoLink: String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let youtubeURL = URL(string: "https://www.youtube.com/embed/\(videoLink)") else {return}
        uiView.scrollView.isScrollEnabled = false
        uiView.load(URLRequest(url: youtubeURL))
        }
}

