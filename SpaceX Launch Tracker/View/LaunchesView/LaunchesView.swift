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
                                }.alert(isPresented: $viewModel.showErrorAlert) {
                                    Alert(title: Text("Cause of Error"), message: Text(viewModel.alertDescription),primaryButton: .default(Text("Close app app"), action: {
                                        quitApp()
                                    }), secondaryButton: .cancel(Text("Try again!"), action: {
                                        viewModel.getLaunchInformation()
                                    })
                                    )
                                    
                                }
                }
                        }.background(Constants.backgroundColor)
        }
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


