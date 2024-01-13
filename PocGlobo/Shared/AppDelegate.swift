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
    
    private func startTaskManager() {
        // Registrar para receber notificações quando um JSON é recebido
        NotificationCenter.default.addObserver(self, selector: #selector(handleJSONReceived(_:)), name: Notification.Name("JSONReceived"), object: nil)
        
        // Iniciar a tarefa em segundo plano
        TaskManager.shared.startBackgroundTask()
    }
    
    @objc func handleJSONReceived(_ notification: Notification) {
        
        if Utils.shared.hasInternetConnection() {
            
            let events = event.selectTopNEvent(limit: Int(TaskEnvironment.numberEvents.rawValue))
            let jsonEncoder = JSONEncoder()
            let jsonData = try! jsonEncoder.encode(events)
            let json = String(data: jsonData, encoding: String.Encoding.utf8)
            
            if let json = json {
                print(json)
            }
        }
    }
    
    //    func showAlert(with json: [String: Any]) {
    //        let alert = UIAlertController(title: "JSON Received", message: "\(json)", preferredStyle: .alert)
    //        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    //        present(alert, animated: true, completion: nil)
    //    }
    
}
