//
//  ContentView.swift
//  SpaceX Launch Tracker
//
//  Created by Berkay on 12.06.2023.
//

import SwiftUI

struct ContentView: View {
    
   
    @State private var searchText = ""
    @State var launches: [Launch] = []
    var body: some View {
        NavigationView {
            VStack{
                HStack{
                    TextField("Search Launches", text: $searchText).textFieldStyle(.roundedBorder).padding(.leading)
                    Button(action: {
                        searchText = ""
                    }) {
                        Image(systemName: "delete.left")
                            .foregroundColor(.red)
                    }
                    .padding(.horizontal)
                }
                
                searchText.isEmpty ?
                    
                // Sorted by launch dates
                List(launches.sorted(by: {$0.dateUnix>$1.dateUnix})) { launch in
                    
                    launchListView(launch: launch)
                    
                }.listStyle(.plain).padding(.horizontal, 10)
                        // Fetching data from api
                            .onAppear{
                                Api().fetchData { (launches) in
                                    self.launches = launches
                                }
                            }
                            
                    :
                   // Sorted by launch dates
                        List(launches.filter {
                            $0.name.range(of: searchText, options: .caseInsensitive) != nil
                        }) { launch in
                            
                            launchListView(launch: launch)
                            
                        }.listStyle(.plain).padding(.horizontal, 10)
                        // Fetching data from api
                            .onAppear{
                                Api().fetchData { (launches) in
                                    self.launches = launches
                                }
                              }
                       }.background(Constants.backgroundColor)
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

extension Color {
    init(hex: UInt32) {
        let red = Double((hex >> 16) & 0xFF) / 255.0
        let green = Double((hex >> 8) & 0xFF) / 255.0
        let blue = Double(hex & 0xFF) / 255.0

        self.init(red: red, green: green, blue: blue)
    }
}

struct launchListView: View {
    var launch : Launch
    var body: some View {
        Text("").listRowBackground(Color.clear)
        
        // Navigating to detail page
        NavigationLink(destination: DetailView(launch: launch, amount: launch.links.flickr.original.count)){
            VStack(alignment: .leading) {
                HStack{
                    if(launch.upcoming == true){
                        Text("Upcoming Launch")
                            .foregroundColor(Color(hex:0xfff48c06))
                            .font(.system(size: 20))
                        Spacer().frame(width: 60)
                    }else{
                        Spacer().frame(width: Constants.screenSize.width * 0.57)
                    }
                    
                    Text(dateFormatter(launchDate: launch.dateUTC)).font(.system(size: 15)).foregroundColor(Color(hex: 0x9ec1a3))
                    
                }
                HStack(spacing: 50) {
                    VStack(alignment: .leading) {
                        AsyncImage(url: URL(string: launch.links.patch.small ?? Constants.defaultRocketPhoto)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 100, height: 100)
                    }
                    Text(launch.name).font(.system(size: 23))
                }
                if let isSuccess = launch.success {
                    if(isSuccess) {
                        Text("Success")
                    }else{
                        Text("Failure")
                    }
                }
            }
        }.frame(height: 150, alignment: .center)
            .listRowBackground(Color(hex: 0xff4a4e69))
            .aspectRatio(contentMode: .fit)
            .foregroundColor(Color(hex: 0xffffba08))
            .opacity(0.8)
            .navigationBarBackButtonHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


