//
//  LaunchesViewModel.swift
//  SpaceX Launch Tracker
//
//  Created by Berkay on 12.06.2023.
//

import Foundation


enum ApiError: Error{
    case networkError,requestError,timeOut,httpError,invalidURL
}

class GetLaunchInfoManager {
    static let shared = GetLaunchInfoManager()
    func fetchData(completion:@escaping (Result<[Launch],ApiError>) -> ()) {
        guard let url = URL(string: "https://api.spacexdata.com/v4/launches") else {
            completion(.failure(ApiError.invalidURL))
            return}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard data != nil else {
                DispatchQueue.main.async {
                    completion(.failure(ApiError.networkError))
                }
                return
            }
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                DispatchQueue.main.async {
                    completion(.failure(ApiError.httpError))
                }
               
                        return
                    }
            
            do {
                let launches = try JSONDecoder().decode([Launch].self, from: data!)
                        
                DispatchQueue.main.async {
                    completion(.success(launches))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(ApiError.requestError))
                }
            }
                 
            
        }
        .resume()
    }
}
