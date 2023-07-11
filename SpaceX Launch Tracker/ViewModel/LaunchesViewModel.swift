//
//  LaunchesViewModel.swift
//  SpaceX Launch Tracker
//
//  Created by Berkay on 19.06.2023.
//

import Foundation

class LaunchesViewModel: ObservableObject {
    private let launchInfoManager: GetLaunchInfoManager
    @Published var launch: [Launch] = []
    @Published var showErrorAlert = false
    @Published var alertDescription = ""
    
    init(launchInfoManager: GetLaunchInfoManager = GetLaunchInfoManager.shared) {
        self.launchInfoManager = launchInfoManager
    }
    
    func getLaunchInformation() {
        launchInfoManager.fetchData { result in
            switch result {
                case .success(let data):
                    self.showErrorAlert = false
                    self.launch = data
                case .failure(let error):
                self.showErrorAlert = true
                switch error {
                case .noResponse:
                    self.alertDescription = "There might be a problem with your internet connection. Please check your connection and try again."
                case .requestError:
                    self.alertDescription = "Some error occured. Please try again later."
                case .invalidURL:
                    self.alertDescription = "Invalid URL"
                    
                default:
                    self.alertDescription = "An error occurred while communicating with the server. Please try again later."
                }
            }
        }
    
        
    }
    
    
    func getOrSearchLaunches(text: String) -> [Launch] {
        return text.isEmpty ? launch.sorted(by: {$0.dateUnix>$1.dateUnix}) : launch.filter { $0.name.range(of: text, options: .caseInsensitive) != nil }
    }
}


