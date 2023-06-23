//
//  QuitApp.swift
//  SpaceX Launch Tracker
//
//  Created by Berkay on 23.06.2023.
//

import UIKit

//Automatically quitting app
func quitApp() {
    UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
        exit(EXIT_SUCCESS)
    }
}

