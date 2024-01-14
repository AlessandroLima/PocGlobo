//
//  Enumerators.swift
//  PocGlobo
//
//  Created by Alessandro Teixeira Lima on 13/01/24.
//

import Foundation

enum TypesOfEvents: String{
    case none
    case openApp
    case openScreen
    case onclick
}

enum DbEnvironment: String {
    case dbName = "myDatabase.sqlite"
    case dbEventTableName = "event"
}

enum TaskEnvironment: UInt32 {
    case waitingTime = 2
    case numberEvents = 10
}

enum ServerEnvironment: String {
    case urlBase = "http://127.0.0.1"
    case port = ":5000"
    case timeOut = "5"
}





