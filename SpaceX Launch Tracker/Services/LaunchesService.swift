//
//  LaunchesViewModel.swift
//  SpaceX Launch Tracker
//
//  Created by Berkay on 12.06.2023.
//

import Foundation

enum ApiError: Error{
    case networkError,requestError,httpError,invalidURL,noResponse
}

class GetLaunchInfoManager {
    static let shared = GetLaunchInfoManager()
    func fetchData(completion:@escaping (Result<[Launch],ApiError>) -> ()) {
        guard let url = URL(string: "https://api.spacexdata.com/v4/launche") else {
            DispatchQueue.main.async {
                completion(.failure(ApiError.invalidURL))
            }
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let launches = try decoder.decode([Launch].self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(launches))
                    }
                } catch {
                    DispatchQueue.main.async {
                        print("Error was occured when decoding: \(error.localizedDescription)")
                        completion(.failure(ApiError.requestError))
                    }
                }
            } else {
                DispatchQueue.main.async {
                    completion(.failure(ApiError.noResponse))
                }
            }
            
          }
        .resume()
    }
}
