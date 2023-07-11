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
                }
                .background(Color(hex: 0xff4a4e69))
                .cornerRadius(15)
                .padding(.all)
                
                
                
                // Show photo's
                photoView(launch: launch, amount: launch.links.flickr.original.count)
                    
                VStack(alignment: .leading){
                    // Show launch details
                    if(launch.details != nil){
                        Text("Details:").fontWeight(.bold)
                        Text(launch.details ?? "").padding(.horizontal, 1)
                        }
                    // Show more information for launch with wikipedia
                    if(launch.links.wikipedia != nil) {
                        learnMoreView(launch.links.wikipedia)
                    }
                }.padding(.all)
                .foregroundColor(.white)
                    .background(launch.details != nil ? Color(hex: 0xff363852) : nil)
                    .cornerRadius(15)
                    .padding(.all)
                    .frame(width: Constants.screenSize.width)
                    
                    
                
                videoView(launch.links.youtubeID)
                
                
                
                
               
                }
        }
        
    }
    
}




struct DetailView_Previews: PreviewProvider {
    static let launch: Launch = Launch(fairings: nil, links: Links(patch: Patch(small: "https://images2.imgbox.com/16/33/EAmegdSP_o.png", large: "https://images2.imgbox.com/27/1c/FaWQjihE_o.png"), reddit: Reddit(campaign: "https://www.reddit.com/r/spacex/comments/t3ez79/axiom1_launch_campaign_thread/", launch: "https://www.reddit.com/r/spacex/comments/tyd866/rspacex_axiom1_launch_discussion_and_updates/", media: nil, recovery: nil), flickr: Flickr(small: [], original: ["https://live.staticflickr.com/65535/51991997860_fa865513ec_o.jpg", "https://live.staticflickr.com/65535/51991997845_85b28ce575_o.jpg", "https://live.staticflickr.com/65535/51990441472_e16a9f15ff_o.jpg", "https://live.staticflickr.com/65535/51991440466_17111d73b6_o.jpg", "https://live.staticflickr.com/65535/51991498488_037537ba40_o.jpg", "https://live.staticflickr.com/65535/51991498473_0e62ee3c34_o.jpg", "https://live.staticflickr.com/65535/51991440451_209bac2fac_o.jpg", "https://live.staticflickr.com/65535/51991997825_345544ff0a_o.jpg", "https://live.staticflickr.com/65535/51990441502_7dfa987137_o.jpg", "https://live.staticflickr.com/65535/51990441532_e9d53093c6_o.jpg"]), presskit: nil, webcast: "https://youtu.be/5nLk_Vqp7nw", youtubeID: "5nLk_Vqp7nw", article: nil, wikipedia: "https://en.wikipedia.org/wiki/Axiom_Mission_1"), staticFireDateUTC: "2022-04-06T19:13:00.000Z", staticFireDateUnix:1649272380, net: false, window: nil, rocket: Rocket.the5E9D0D95Eda69973A809D1Ec, success: true, failures: [], details: "Axiom Mission 1 (or Ax-1) is a planned SpaceX Crew Dragon mission to the International Space Station (ISS), operated by SpaceX on behalf of Axiom Space. The flight will launch no earlier than 31 March 2022 and send four people to the ISS for an eight-day stay", crew: ["61eefc9c9eb1064137a1bd77", "61eefcf89eb1064137a1bd79", "61eefd5b9eb1064137a1bd7a", "61eefdbf9eb1064137a1bd7b"], ships: ["5ea6ed2e080df4000697c909"], capsules: ["5e9e2c5df359188aba3b2676"], payloads: ["61eefb129eb1064137a1bd74"], launchpad: Launchpad.the5E9E4502F509094188566F88, flightNumber: 156, name: "Ax-1", dateUTC: "2022-04-08T15:17:00.000Z", dateUnix: 1649431020, dateLocal: "2022-04-08T11:17:00-04:00", datePrecision: DatePrecision.hour, upcoming: false, cores: [Core(core: "5f57c5440622a633027900a0", flight: 5, gridfins: true, legs: true, reused: true, landingAttempt: true, landingSuccess: true, landingType: LandingType.asds, landpad: Landpad.the5E9E3033383Ecb075134E7CD)], autoUpdate: true, tbd: false, launchLibraryID: "a3eeb03b-a209-4255-91b5-772dc0d2150e", id: "61eefaa89eb1064137a1bd73")
    static var previews: some View {
        
        DetailView(launch: launch)
    }
}


