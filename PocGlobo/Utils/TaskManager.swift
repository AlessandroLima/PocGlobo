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
            // Simulando o recebimento de um JSON a cada 10 segundos
            if let json = fetchJSON() {
                // Notificar a interface do usuário para exibir um alerta
                NotificationCenter.default.post(name: Notification.Name("JSONReceived"), object: json)
            }

            // Aguardar 10 segundos antes da próxima iteração
            sleep(TaskEnvironment.waitingTime.rawValue)
        }
    }

    private func fetchJSON() -> [String: Any]? {
        // Simulando o recebimento de um JSON
        return ["key": "value"]
    }

    private func endBackgroundTask() {
        UIApplication.shared.endBackgroundTask(backgroundTask)
        backgroundTask = .invalid
    }
}
