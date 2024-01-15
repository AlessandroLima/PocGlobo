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
        
        createEventTable()
        addEventOpenApp()
        _ = DBConstants()
        _ = JsonProcessor()
        
        return true
    }
    
    private func createEventTable() {
        
        if let db = DBConstants.db {
            
            event.setManagerAndDB(manager: DBConstants.sqliteManager, db: db)
            event.createTable()
        }
    }
    
    private func addEventOpenApp() {
        let eventToInsert = [
            Event(type: "\(TypesOfEvents.openApp)", createdIn: "\(NSDate().timeIntervalSince1970)")
        ]
        _ = event.insertEventInBatch(events: eventToInsert)
    }
    
}

