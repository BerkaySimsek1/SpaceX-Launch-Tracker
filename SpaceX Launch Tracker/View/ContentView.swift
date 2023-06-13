//
//  ContentView.swift
//  SpaceX Launch Tracker
//
//  Created by Berkay on 12.06.2023.
//

import SwiftUI

struct ContentView: View {
  
    
    
    @State var launches: [Launch] = []
    var body: some View {
        
        NavigationView{
            // Sorted by launch dates
            List(launches.sorted(by: {$0.dateUnix>$1.dateUnix})) { launch in
                
                    // Gets upcoming launches
                    if(launch.upcoming == true){
                        Text("Upcoming Launch").listRowBackground(Color.clear)
                    }else{
                        Color.clear
                    }
                    
                NavigationLink(destination: DetailView(launch: launch, amount: launch.links.flickr.original.count)){
                    HStack {
                        AsyncImage(url: URL(string: launch.links.patch.small ?? Constants.defaultRocketPhoto)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 150, height: 150)
                        VStack{
                           
                            Text(dateFormatter(launchDate: launch.dateUTC))
                            Text(launch.name)
                            if let isSuccess = launch.success {
                                
                                if(isSuccess) {
                                    
                                    Text("Success")
                                }else{
                                    Text("Failure")
                                }
                            }
                            
                            
                        }
                    }
                }.listRowBackground(Constants.listBackgroundColor)
            }
            // Fetching data from api
            .onAppear{
                Api().fetchData { (launches) in
                    self.launches = launches
                }
            }
            
            
        }
    }
}

func dateFormatter(launchDate:String) -> String{
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"

    if let date = dateFormatter.date(from: launchDate) {
        dateFormatter.dateFormat = "dd MMM yyyy"
        let formattedDate = dateFormatter.string(from: date)
       
        return formattedDate
    } else {
        print("Invalid date format")
        return ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


