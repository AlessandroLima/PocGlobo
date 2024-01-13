//
//  AppDelegate.swift
//  PocGlobo
//
//  Created by Alessandro Teixeira Lima on 12/01/24.
//

import UIKit


class AppDelegate: NSObject, UIApplicationDelegate {

    var sqliteManager = SQLiteManager()
    var db: OpaquePointer?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setDBManager()
        createEventTable()
        return true
    }
    
    private func setDBManager() {
        let manager = sqliteManager.openOrCreateDatabase(databaseName: "myDatabase.sqlite")
        db = manager.db
        
    }
    
    
    
    private func createEventTable() {

        if let db = self.db {

            lazy var event: Event = {
                return Event()
            }()

            event.setManagerAndDB(manager: self.sqliteManager, db: db)
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
