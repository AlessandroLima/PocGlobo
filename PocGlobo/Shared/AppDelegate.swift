//
//  AppDelegate.swift
//  PocGlobo
//
//  Created by Alessandro Teixeira Lima on 12/01/24.
//

import UIKit

class DBConstants {
    
    static let sqliteManager: SQLiteManager = SQLiteManager()
    static let db: OpaquePointer?  = {
        return DBConstants.sqliteManager.openOrCreateDatabase(databaseName: DbEnvironment.dbName.rawValue).db
    }()
}



class AppDelegate: NSObject, UIApplicationDelegate {
    
    lazy var event: Event = { return Event() }()
    
    lazy var manager =  HTTPRequestManager()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        _ = DBConstants()
        createEventTable()
        startTaskManager()
        return true
    }
    
    private func createEventTable() {
        
        if let db = DBConstants.db {
            
            event.setManagerAndDB(manager: DBConstants.sqliteManager, db: db)
            event.createTable()
            
            let eventToInsert = [
                Event(type: "\(TypesOfEvents.openApp)", createdIn: "\(NSDate().timeIntervalSince1970)")
            ]
            
            _ = event.insertEventInBatch(events: eventToInsert)
        }
    }
    
    private func startTaskManager() {
        // Registrar para receber notificações quando um JSON é recebido
        NotificationCenter.default.addObserver(self, selector: #selector(handleJSONReceived(_:)), name: Notification.Name("JSONReceived"), object: nil)
        
        // Iniciar a tarefa em segundo plano
        TaskManager.shared.startBackgroundTask()
    }
    
    @objc func handleJSONReceived(_ notification: Notification) {
        
        var ids:[Int] = []
        
        if Utils.shared.hasInternetConnection() {
            
            let events = event.selectTopNEvent(limit: Int(TaskEnvironment.numberEvents.rawValue))
            let jsonEncoder = JSONEncoder()
            let jsonData = try! jsonEncoder.encode(events)
            //let json = String(data: jsonData, encoding: String.Encoding.utf8)
            
            if let jsonObject = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                let extractedIds = event.extractIds(from: jsonObject)
                ids = extractedIds
                print(ids)
            } else {
                print("Error processing JSON.")
            }
            
            if ids.count > 0 {
                manager.makePostRequest(with: jsonData) { result in
                    switch result {
                    case .success(let success):
                        success == true ? print("Request successful: \(success)") : print("Request fail: \(success)")
                    case .failure(let error):
                        switch error {
                        case .timeout:
                            print("Request timed out")
                        case .invalidResponse:
                            print("Invalid response")
                        case .requestFailed(let underlyingError):
                            print("Request failed with underlying error: \(underlyingError)")
                        }
                    }
                }
            } else {
                TaskManager.shared.endBackgroundTask()
            }
        }
        
    }
}

