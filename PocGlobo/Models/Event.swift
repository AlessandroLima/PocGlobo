import Foundation
import SQLite3

class Event: SQLiteBaseModel, SQLiteBaseModelType {
    
    var id: Int
    var name: String
    private let tableName = "event"
    
    //Placeholder
    init(id: Int = 0, name: String = "") {
        self.id = id
        self.name = name
    }
    
    func createTable(){
        let sqlString = super.createTableString(name: "event")
        if let manager = super.manager, let db = super.db {
            _ = manager.createTableFromModel(modelName: sqlString, in: db)
        }
    }
    
    func insertPeopleInBatch(events: [Event]) -> Bool {
        
        if let manager = manager {
            
            if sqlite3_open(manager.databasePath, &super.db) != SQLITE_OK {
                print("Error opening database.")
                return false
            }
            
            let insertStatementString = "INSERT INTO \("event") (name) VALUES (?)"
            var insertStatement: OpaquePointer? = nil
            
            if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) != SQLITE_OK {
                print("Error preparing insert statement.")
                return false
            }
            
            sqlite3_exec(db, "BEGIN TRANSACTION", nil, nil, nil) // Iniciar uma transação
            
            for event in events {
                let itemName = event.name as NSString
                sqlite3_bind_text(insertStatement, 1, itemName.utf8String, -1, nil)
                //sqlite3_bind_int(insertStatement, 2, Int32(person.idade))
                
                if sqlite3_step(insertStatement) != SQLITE_DONE {
                    print("Error inserting event")
                    return false
                }
                
                sqlite3_reset(insertStatement)
            }
            
            sqlite3_exec(db, "COMMIT", nil, nil, nil) // Commit da transação
            
            sqlite3_finalize(insertStatement)
            sqlite3_close(db)
        } else {
            return false
        }
        
        print("Events inserted successfully!")
        return true
    }
    
    func selectTopNEvent(limit: Int) -> [Event]? {
        
        var events: [Event] = []

        if sqlite3_open(self.manager?.databasePath, &super.db) != SQLITE_OK {
            print("Error opening database.")
            return nil
        }

        let selectStatementString = "SELECT * FROM \("event") ORDER BY id DESC LIMIT ?"
        var selectStatement: OpaquePointer? = nil

        if sqlite3_prepare_v2(super.db, selectStatementString, -1, &selectStatement, nil) != SQLITE_OK {
            print("Error preparing selection statement.")
            return nil
        }

        sqlite3_bind_int(selectStatement, 1, Int32(limit))

        while sqlite3_step(selectStatement) == SQLITE_ROW {
            let id = Int(sqlite3_column_int(selectStatement, 0))
            let name = String(cString: sqlite3_column_text(selectStatement, 1))
            //let age = Int(sqlite3_column_int(selectStatement, 2))
            let event = Event(id: id, name: name)
            events.append(event)
        }

        sqlite3_finalize(selectStatement)
        sqlite3_close(db)

        return events
    }
    
    func deleteRowsInBatch(ids: [Int]) -> Bool {
        var db: OpaquePointer? = nil

        if sqlite3_open(self.manager?.databasePath, &super.db) != SQLITE_OK {
            print("Error opening database.")
            return false
        }

        let deleteStatementString = "DELETE FROM \(tableName) WHERE id IN (\(ids.map { String($0) }.joined(separator: ",")))"

        if sqlite3_exec(super.db, deleteStatementString, nil, nil, nil) != SQLITE_OK {
            print("Error executing batch delete statement.")
            return false
        }

        sqlite3_close(db)

        return true
    }
    
}
