//
//  DetailView.swift
//  SpaceX Launch Tracker
//
//  Created by Berkay on 12.06.2023.
//

import SwiftUI
import WebKit
struct DetailView: View {
    @State var launch: Launch
    @State var amount: Int
    @State private var currentIndex = 0
    
    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
        
    
    
    var body: some View {
        
        ScrollView {
            HStack{
                AsyncImage(url: URL(string: launch.links.patch.large ?? Constants.defaultRocketPhoto)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }.frame(width: 100,height: 100)
                
                Text(launch.name)
            }
            if(launch.links.webcast != nil){
                EmbedView(videoLink: launch.links.youtubeID!).frame(height: Constants.screenSize.height * 0.3,alignment: .leading)
                    .cornerRadius(12)
                    .padding(.horizontal,24)
            }
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
                            
                            .onReceive(timer) { _ in
                                currentIndex = currentIndex < amount-1 ? currentIndex + 1 : 0
                                withAnimation{value.scrollTo(currentIndex)}
                            }
                        }
                    }
                    
                    
                }
                .scrollDisabled(true)
                .frame(width: Constants.screenSize.width, height: Constants.screenSize.height/3)
            }
            if(amount != 0) {Text("\(currentIndex+1)/\(amount)")}
            Text(launch.details ?? "")
            
            if(launch.links.wikipedia != nil) {Link("Learn More", destination: URL(string: launch.links.wikipedia!)!)}
            
            
            
        }
    }
    
}

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


//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView(launch: )
//    }
//}
