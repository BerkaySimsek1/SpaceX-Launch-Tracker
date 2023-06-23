//
//  DateFormatter.swift
//  SpaceX Launch Tracker
//
//  Created by Berkay on 23.06.2023.
//

import Foundation

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
