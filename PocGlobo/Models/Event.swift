import Foundation
import SQLite3

struct Events: Codable {
    var events: [Event] = []
}

class Event: SQLiteBaseModel, SQLiteBaseModelType, Codable {
    
    var id: Int
    var type: String
    var createdIn: String
    
    //Placeholder
    init(id: Int = 0, type: String = "", createdIn: String = "") {
        self.id = id
        self.type = type
        self.createdIn = createdIn
    }
    
    func createTable(){
        let sqlString = super.createTableString(name: DbEnvironment.dbEventTableName.rawValue)
        if let manager = super.manager, let db = super.db {
            _ = manager.createTableFromModel(modelName: sqlString, in: db)
        }
    }
    
    func insertEventInBatch(events: [Event]) -> Bool {
        
        if let manager = manager {
            
            if sqlite3_open(manager.databasePath, &super.db) != SQLITE_OK {
                print("Error opening database.")
                return false
            }
            
            let insertStatementString = "INSERT INTO \(DbEnvironment.dbEventTableName.rawValue) (type, createdIn) VALUES (?, ?)"
            var insertStatement: OpaquePointer? = nil
            
            if sqlite3_prepare_v2(super.db, insertStatementString, -1, &insertStatement, nil) != SQLITE_OK {
                print("Error preparing insert statement.")
                return false
            }
            
            sqlite3_exec(super.db, "BEGIN TRANSACTION", nil, nil, nil)
            
            for event in events {
                let itemType = event.type as NSString
                let itemcreatedIn = event.createdIn as NSString
                sqlite3_bind_text(insertStatement, 1, itemType.utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 2, itemcreatedIn.utf8String, -1, nil)
                
                if sqlite3_step(insertStatement) != SQLITE_DONE {
                    print("Error inserting event")
                    return false
                }
                
                sqlite3_reset(insertStatement)
            }
            
            sqlite3_exec(super.db, "COMMIT", nil, nil, nil)
            
            sqlite3_finalize(insertStatement)
            sqlite3_close(super.db)
        } else {
            return false
        }
        
        return true
    }
    
    func selectTopNEvent(limit: Int) -> Events? {
        
        var events: [Event] = []

        if sqlite3_open(self.manager?.databasePath, &super.db) != SQLITE_OK {
            print("Error opening database.")
            return nil
        }

        let selectStatementString = "SELECT * FROM \(DbEnvironment.dbEventTableName.rawValue) ORDER BY id DESC LIMIT ?"
        var selectStatement: OpaquePointer? = nil

        if sqlite3_prepare_v2(super.db, selectStatementString, -1, &selectStatement, nil) != SQLITE_OK {
            print("Error preparing selection statement.")
            return nil
        }

        sqlite3_bind_int(selectStatement, 1, Int32(limit))

        while sqlite3_step(selectStatement) == SQLITE_ROW {
            let id = Int(sqlite3_column_int(selectStatement, 0))
            let type = String(cString: sqlite3_column_text(selectStatement, 1))
            let createdIn = String(cString: sqlite3_column_text(selectStatement, 2))
            let event = Event(id: id, type: type, createdIn: createdIn)
            events.append(event)
        }

        sqlite3_finalize(selectStatement)
        sqlite3_close(super.db)
        
        let setOfEvents = Events.init(events: events)
            
        if setOfEvents.events.count > 0 {
            return setOfEvents
        }
        
        return Events.init(events: [])
    }
    
    func deleteRowsInBatch(ids: [Int]) -> Bool {
        
        if sqlite3_open(self.manager?.databasePath, &super.db) != SQLITE_OK {
            print("Error opening database.")
            return false
        }

        let deleteStatementString = "DELETE FROM \(DbEnvironment.dbEventTableName.rawValue) WHERE id IN (\(ids.map { String($0) }.joined(separator: ",")))"

        if sqlite3_exec(super.db, deleteStatementString, nil, nil, nil) != SQLITE_OK {
            print("Error executing batch delete statement.")
            return false
        }

        sqlite3_close(super.db)

        return true
    }
    
    func extractIds(from json: [String: Any]) -> [Int] {
        var idArray: [Int] = []

        if let events = json["events"] as? [[String: Any]] {
            for event in events {
                if let id = event["id"] as? Int {
                    idArray.append(id)
                }
            }
        }

        return idArray
    }
    
}
