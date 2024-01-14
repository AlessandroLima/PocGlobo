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
    case waitingTime = 15
    case numberEvents = 10
}

enum ServerEnvironment: String {
    case urlBase = "http://localhost"
    case port = ":500"
    case timeOut = "5"
}





