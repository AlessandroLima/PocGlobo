//
//  HomeViewModel.swift
//  PocGlobo
//
//  Created by Alessandro Teixeira Lima on 13/01/24.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    
    let manager = DBConstants.sqliteManager
    let db = DBConstants.db
    lazy var event: Event = { return Event() }()
    
    init() {
        
        if let db = db {
            event.setManagerAndDB(manager: manager, db: db)
        }
        
        let eventToInsert = [
            Event(type: "\(TypesOfEvents.openScreen)", createdIn: "\(NSDate().timeIntervalSince1970)")
        ]
        
        _ = event.insertEventInBatch(events: eventToInsert)
    
    }

    func login() {
        print("Login Button Pressed")
        print("Username: \(username)")
        print("Password: \(password)")
        
        let eventToInsert = [
            Event(type: "\(TypesOfEvents.onclick)",
                  createdIn: "\(NSDate().timeIntervalSince1970)")
        ]
        _ = event.insertEventInBatch(events: eventToInsert)
        
    }
    
    func addEvents() {
        for _ in 1...100 {
            let eventToInsert = [Event(type: "\(TypesOfEvents.onclick)",
                                       createdIn: "\(NSDate().timeIntervalSince1970)")]
            _ = event.insertEventInBatch(events: eventToInsert)
        }
    }
}
