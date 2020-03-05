//
//  DBManager.swift
//  DemoAlamofire
//
//  Created by Tuan Cuong on 3/2/20.
//  Copyright © 2020 Tuan Cuong. All rights reserved.
//

import UIKit
import FMDB

class DBManager: NSObject {
    static let shared: DBManager = DBManager()
    private var pathToDatabase: String!
    private var queue: FMDatabaseQueue! = nil
    
    override init() {
        super.init()
        
        // get path form document
        let documentsDirectory = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString) as String
        pathToDatabase = documentsDirectory.appending("/local.db")
        print("Path: \(pathToDatabase)")
        if FileManager.default.fileExists(atPath: pathToDatabase) {
            let queue = FMDatabaseQueue(path: pathToDatabase)
            queue?.inDatabase({ (db: FMDatabase!) in
                do{
                    if db.open() {
                        self.queue = queue
                    }
                    db.close()
                }
            })
        }
    }
    
    func openDatabase() -> Bool {
        if queue == nil {
//            Check Database is exists
            if FileManager.default.fileExists(atPath: pathToDatabase) {
                queue=FMDatabaseQueue(path: pathToDatabase)
            }
        }
        
        if queue != nil {
            return true
        }
        return false
    }
    
    func createDatabase() -> Bool {
        var created = false
        
        if !FileManager.default.fileExists(atPath: pathToDatabase) {
            let db = FMDatabase(path: pathToDatabase)
            if db.open() {
                let sql = "create table Audio (_id integer primary key autoincrement, title text, thumbnail text, description text)"
                do {
                    try db.executeUpdate(sql, values: nil)
                    created = true
                } catch {
                    print("Could not create table")
                }
                
                db.close()
            }
        }
        
        return created
    }
    
    func insterAudio(audio: Audio) {
        if openDatabase() {
            queue.inDatabase( { (db: FMDatabase!) in
                db.open()
//                 data.thumbnail!.url!
                var description: String = "Demo Description"
//                if audio.description != nil {
//                    description = audio.description!
//                }
                
                
                let sql = "insert into Audio (title, thumbnail, description) values ('\(audio.title!)','\(audio.thumbnail!.url!)','\(description )')"
                print("SQL: \(sql)")
                
                if !db.executeStatements(sql) {
                    print("Failded to insert Audio ")
                }
                db.close()
            })
        }
    }
    
}
