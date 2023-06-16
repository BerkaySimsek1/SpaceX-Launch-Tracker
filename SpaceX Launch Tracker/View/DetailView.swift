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
    @State var showingPopup = false
        
         
    
    var body: some View {
        ZStack{
            Constants.backgroundColor.ignoresSafeArea(.all).frame(maxWidth: .infinity, maxHeight: .infinity)
            
            ScrollView {
                HStack {
                    VStack {
                        Text(launch.name).font(.largeTitle)
                        Text(dateFormatter(launchDate: launch.dateUTC)).font(.system(size: 13)).foregroundColor(Color(hex: 0x9ec1a3))
                    }.padding(.leading, 25)
                    
                    Spacer()
                    if let isSuccess = launch.success {
                        if(isSuccess){
                            customTextView(customText: "Success",customColor: Color(hex: 0xff609966))
                        }
                        else{
                            customTextView(customText: "Failure", customColor: Color.red)
                        }
                    }
                    if(launch.upcoming) {
                        customTextView(customText: "Upcoming", customColor: Color.orange)
                    }
                }.edgesIgnoringSafeArea(.all).padding(.all).background(Color(hex: 0xff4a4e69)).cornerRadius(15).padding(.horizontal)
                
                
                
                
                photoView(launch: launch, amount: amount)
                    
                VStack(alignment: .leading){
                    Text(launch.details ?? "").padding(.horizontal, 5)
                    
                    if(launch.links.wikipedia != nil) {
                        
                        Text("Learn more").font(.system(size: 15))
                            .padding(.all, 3)
                            .background(Color(hex: 0xff70a9a1))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .onTapGesture {
                                // Handle link tap action
                                guard let url = URL(string: launch.links.wikipedia!) else { return }
                                UIApplication.shared.open(url)
                            }
                    }
                }.foregroundColor(.white).padding(.all).background(launch.details != nil ? Color(hex: 0xff363852) : nil).cornerRadius(15).padding(.horizontal)
                
                if(launch.links.webcast != nil){
                    VStack(alignment: .leading){
                        Text("Launch Video:").padding(.horizontal)
                        EmbedView(videoLink: launch.links.youtubeID!).frame(height: Constants.screenSize.height * 0.3,alignment: .leading)
                            .cornerRadius(12)
                            .padding(.horizontal,24)
                    }.edgesIgnoringSafeArea(.all).padding(.all).background(Color(hex: 0xff4a4e69)).cornerRadius(15).padding(.horizontal)
                }
                
                
                
               
                }
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
    }
}




//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView(launch: )
//    }
//}

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
