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
    
    init(launchInfoManager: GetLaunchInfoManager = GetLaunchInfoManager.shared) {
        self.launchInfoManager = launchInfoManager
    }
    
    func getLaunchInformation() {
        launchInfoManager.fetchData { launch in
            
            self.launch = launch
        }
    }
    
    
    func getOrSearchLaunches(text: String) -> [Launch] {
        if text.isEmpty{
            return launch.sorted(by: {$0.dateUnix>$1.dateUnix})
        }
        else{
            return launch.filter {
                            $0.name.range(of: text, options: .caseInsensitive) != nil
                        }
        }
    }
    
    
}


