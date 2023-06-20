//
//  ContentView.swift
//  SpaceX Launch Tracker
//
//  Created by Berkay on 12.06.2023.
//

import SwiftUI

struct ContentView: View {
    
   
    @State private var searchText = ""
    @ObservedObject var viewModel = LaunchesViewModel()
    var body: some View {
        NavigationView {
            VStack{
                
                // Search View
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
                
                // Listview of launches, making search or listing all launches
                ScrollView {
                    ForEach(viewModel.getOrSearchLaunches(text: searchText)) { launch in
                        launchListView(launch: launch)}
                    .listStyle(.plain)
                        .padding(.horizontal, 10)
                            // Fetching data from api
                                .onAppear{
                                    viewModel.getLaunchInformation()
                            }
                }
                        }.background(Constants.backgroundColor)
        }
        
    }
}



// Formatting date
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


// Use colors with hex code
extension Color {
    init(hex: UInt32) {
        let red = Double((hex >> 16) & 0xFF) / 255.0
        let green = Double((hex >> 8) & 0xFF) / 255.0
        let blue = Double(hex & 0xFF) / 255.0

        self.init(red: red, green: green, blue: blue)
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


