//
//  DBHelper.swift
//  Tic Tak Toe Game
//
//  Created by R95 on 28/05/24.
//

import Foundation
import SQLite3
import UIKit

class SqliteFile {
    static var file: OpaquePointer?
    
    static func createFile() {
        var a = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        a.appendPathExtension("Tic Tak Toe Game User.db")
        sqlite3_open(a.path, &file)
        print("Crecet path")
        print(a.path)
        crecetTable()
    }
    
    static func crecetTable() {
        let q = "Create Table if not exists Users (email text, password text)"
        var table : OpaquePointer?
        sqlite3_prepare(file, q, -1, &table, nil)
        sqlite3_step(table)
        print("Create Table")
    }
    
    static func addData(email: String, password: String) {
        let q = "insert into users values ('\(email)','\(password)')"
        var addData : OpaquePointer?
        sqlite3_prepare(file, q, -1, &addData, nil)
        sqlite3_step(addData)
        print("Add Data\n")
    }
    
    static func getData() {
        let q = "SELECT * FROM Users"
        var getData : OpaquePointer?
        sqlite3_prepare(file, q, -1, &getData, nil)
        while sqlite3_step(getData) == SQLITE_ROW {
            if let email = sqlite3_column_text(getData, 0) {
                print(String(cString: email))
            }
            if let password = sqlite3_column_text(getData, 1) {
                print(String(cString: password))
            }
        }
        print("Get Data")
    }
}
