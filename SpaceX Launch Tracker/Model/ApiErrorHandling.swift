//
//  apiErrorHandling.swift
//  SpaceX Launch Tracker
//
//  Created by Berkay on 20.06.2023.
//

import Foundation

enum ApiError: Error{
    case networkError,requestError
    
    var description: String {
        switch self {
        case .networkError:
                return "Network error. Please check your internet connection."
        case .requestError:
                return "We couldn't reach launch informations. Please try again later!"
        }
    }
}
