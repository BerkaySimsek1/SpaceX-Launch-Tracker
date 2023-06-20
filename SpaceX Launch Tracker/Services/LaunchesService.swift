//
//  LaunchesViewModel.swift
//  SpaceX Launch Tracker
//
//  Created by Berkay on 12.06.2023.
//

import Foundation

class GetLaunchInfoManager {
    static let shared = GetLaunchInfoManager()
    func fetchData(completion:@escaping ([Launch]) -> ()) {
        guard let url = URL(string: "https://api.spacexdata.com/v4/launches") else {return}
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            
                
                    do {
                        let launches = try JSONDecoder().decode([Launch].self, from: data!)
                        
                        DispatchQueue.main.async {
                            completion(launches)
                        }
                    } catch {
                        print(String(describing: error))
                        print(error.localizedDescription)
                    }
                 
            
        }
        .resume()
    }
}
