//
//  DBHelper.swift
//  iosApp
//
//  Created by Nurgun Nalyiakhov on 20.05.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

/*import Foundation
import SQLite3
import UIKit

class DBHelper {
    init() {
        db = openDatabase()
        createTable()
    }

    let dbPath: String = "myDb.sqlite"
    var db: OpaquePointer?

    func openDatabase() -> OpaquePointer? {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(dbPath)
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
            return nil
        } else {
            print("Successfully opened connection to database at \(dbPath)")
            return db
        }
    }

    func createTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS favoriteImages(id INTEGER PRIMARY KEY,path TEXT,image INTEGER);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("person table created.")
            } else {
                print("person table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    
    func insert(id:Int, name:String, age:Int) {
        let favoriteImages = read()
        for favoriteImage in favoriteImages {
            if favoriteImage.id == id {
                return
            }
        }
        let insertStatementString = "INSERT INTO favoriteImages (id, path, image) VALUES (NULL, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (name as NSString).utf8String, -1, nil)
            sqlite3_bind_int(insertStatement, 2, Int32(age))
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    func read() -> [FavoriteImage] {
        let queryStatementString = "SELECT * FROM favoriteImages;"
        var queryStatement: OpaquePointer? = nil
        var favoriteImages: [FavoriteImage] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let path = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let image = UIImage()//sqlite3_column_(queryStatement, 2)
                favoriteImages.append(FavoriteImage(id: id, path: path, image: image))
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return favoriteImages
    }
    
    func deleteByID(id: Int) {
        let deleteStatementStirng = "DELETE FROM favoriteImages WHERE Id = ?;"
        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(deleteStatement, 1, Int32(id))
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted row.")
            } else {
                print("Could not delete row.")
            }
        } else {
            print("DELETE statement could not be prepared")
        }
        sqlite3_finalize(deleteStatement)
    }
}*/
