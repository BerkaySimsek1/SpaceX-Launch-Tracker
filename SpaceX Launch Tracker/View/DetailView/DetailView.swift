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
        ZStack(alignment: .topLeading){
            Constants.backgroundColor.ignoresSafeArea(.all).frame(maxWidth: .infinity, maxHeight: .infinity)
            
            ScrollView {
                HStack {
                    VStack {
                        // Show name and formatted date from top
                        Text(launch.name).font(.largeTitle)
                        Text(dateFormatter(launchDate: launch.dateUTC)).font(.system(size: 13)).foregroundColor(Color(hex: 0x9ec1a3))
                    }.padding(.leading, 25)
                    
                    Spacer()
                    
                    // Show if launch is succes, failure or upcoming
                    if let isSuccess = launch.success {
                        if(isSuccess){
                            customTextView(customText: "Success",customColor: Color(hex: 0xff609966))
                        }
                        else{
                            customTextView(customText: "Failure", customColor: Color.red).onTapGesture {
                                showingPopup = true
                            }.alert(isPresented: $showingPopup){
                                Alert(title: Text("Cause of Failure"), message: Text(launch.failures[0].reason),dismissButton: .default(Text("Got it!")))
                            }
                        }
                    }
                    if(launch.upcoming) {
                        customTextView(customText: "Upcoming", customColor: Color.orange)
                    }
                }.edgesIgnoringSafeArea(.all).padding(.all).background(Color(hex: 0xff4a4e69)).cornerRadius(15).padding(.horizontal)
                
                
                
                // Show photo's
                photoView(launch: launch, amount: amount)
                    
                VStack(alignment: .leading){
                    // Show launch details
                    if(launch.details != nil){
                        Text("Details:").fontWeight(.bold)
                        detailDescriptionView(launch.details)
                        }
                    // Show more information for launch with wikipedia
                    if(launch.links.wikipedia != nil) {
                        learnMoreView(launch.links.wikipedia)
                    }
                }.foregroundColor(.white).padding(.all).background(launch.details != nil ? Color(hex: 0xff363852) : nil).frame(width: Constants.screenSize.width).cornerRadius(15).padding(.all)
                
                videoView(launch.links.youtubeID)
                
                
                
                
               
                }
        }
        
    }
    
}

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

func detailDescriptionView(_ text: String?) -> some View {
    Text(text ?? "").padding(.horizontal, 5)
}






//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView(launch: )
//    }
//}


