//
//  TaskManager.swift
//  PocGlobo
//
//  Created by Alessandro Teixeira Lima on 13/01/24.
//

import Foundation

import UIKit

class TaskManager {
    
    static let shared = TaskManager()
    
    private var backgroundTask: UIBackgroundTaskIdentifier = .invalid
    
    func startBackgroundTask() {
        backgroundTask = UIApplication.shared.beginBackgroundTask {
            self.endBackgroundTask()
        }
        
        DispatchQueue.global(qos: .background).async {
            self.runInBackground()
        }
    }
    
    private func runInBackground() {
        while true {
            NotificationCenter.default.post(name: Notification.Name("JSONReceived"), object: nil)
            sleep(TaskEnvironment.waitingTime.rawValue)
        }
    }
    
    func endBackgroundTask() {
        UIApplication.shared.endBackgroundTask(backgroundTask)
        backgroundTask = .invalid
    }
}
