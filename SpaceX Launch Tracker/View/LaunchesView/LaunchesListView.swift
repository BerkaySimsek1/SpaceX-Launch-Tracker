//
//  LaunchesListView.swift
//  SpaceX Launch Tracker
//
//  Created by Berkay on 19.06.2023.
//

import SwiftUI

// Listview of Launches
struct launchListView: View {
    var launch : Launch
    var body: some View {
        Text("").listRowBackground(Color.clear)
        
        // Navigating to detail page
        NavigationLink(destination: DetailView(launch: launch, amount: launch.links.flickr.original.count)){
            VStack(alignment: .leading) {
                HStack{
                    // Show upcoming launches
                    upcomingView(launch.upcoming)
                    // Show formatted date
                    dateView(launch.dateUTC)
                    }
                
                HStack(spacing: 50) {
                   // Show logos
                    launchLogoView(launch.links.patch.small)
                    Spacer()
                    // Show name
                    launchNameView(launch.name)
                }
                // Show whether launch is succes or not
                launchSuccesOrFailureView(launch.success)
            }.padding(.all)
        }.frame(width: Constants.screenSize.width*0.95, height: 200, alignment: .center)
            .background(Color(hex: 0xff4a4e69))
            .cornerRadius(10)
            .aspectRatio(contentMode: .fit)
            .foregroundColor(Color(hex: 0xffffba08))
            .navigationBarBackButtonHidden(true)
            .padding(.bottom)
    }
}


@ViewBuilder
func upcomingView(_ upcoming: Bool) -> some View {
    if(upcoming){
        Text("Upcoming Launch")
            .foregroundColor(Color(hex:0xfff48c06))
            .font(.system(size: 20))
        Spacer().frame(width: 60)
    }else{
        Spacer().frame(width: Constants.screenSize.width * 0.57)
    }
}


@ViewBuilder
func dateView(_ date: String) -> some View {
    Text(dateFormatter(launchDate: date)).font(.system(size: 15)).foregroundColor(Color(hex: 0x9ec1a3))
}

@ViewBuilder
func launchLogoView(_ image: String?) -> some View {
    AsyncImage(url: URL(string: image ?? Constants.defaultRocketPhoto)) { image in
        image
            .resizable()
            .aspectRatio(contentMode: .fit)
    } placeholder: {
        ProgressView()
    }
    .frame(width: 100, height: 100)
}

@ViewBuilder
func launchNameView(_ name: String) -> some View {
    Text(name).font(.system(size: 23)).frame(width: Constants.screenSize.width/3)
}

@ViewBuilder
func launchSuccesOrFailureView(_ isSuccess: Bool?) -> some View {
    if let isSuccess = isSuccess {
        if(isSuccess) {
            Text("Success")
        }else{
            Text("Failure")
        }
    }
}
