//
//  AppDelegate.swift
//  PocGlobo
//
//  Created by Alessandro Teixeira Lima on 12/01/24.
//

import UIKit

class DBConstants {
    
    static let sqliteManager: SQLiteManager = SQLiteManager()
    static var db: OpaquePointer?
    private var dbName = "myDatabase.sqlite"
    
    init() {
        let dbManager = DBConstants.sqliteManager.openOrCreateDatabase(databaseName: dbName)
        DBConstants.db = dbManager.db
    }
}



class AppDelegate: NSObject, UIApplicationDelegate {
    
    lazy var event: Event = { return Event() }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        _ = DBConstants()
        createEventTable()
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
            
            //            let peopleToInsert = [
            //                Pessoa(nome: "Alice", idade: 4),
            //                Pessoa(nome: "Ale", idade: 50),
            //                Pessoa(nome: "Mi", idade: 39),
            //                Pessoa(nome: "Pedro", idade: 0),
            //                Pessoa(nome: "Alice2", idade: 4),
            //                Pessoa(nome: "Ale2", idade: 50),
            //                Pessoa(nome: "Mi2", idade: 39),
            //                Pessoa(nome: "Pedro2", idade: 0),
            //            ]
            //
            //            _ = person.insertPeopleInBatch(people: peopleToInsert)
            //
            //            _ = person.deleteRowsInBatch(ids: [1,2,3,4])
            //
            //            let persons = person.selectTopNPeople(limit: 10)
            //
            //            if let persons = persons {
            //                for person in persons {
            //                    print("Id: \(person.id), Nome: \(person.nome), Idade: \(person.idade)")
            //                }
            //            }
        }
    }
    
    
}
