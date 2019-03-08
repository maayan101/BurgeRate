//
//  ReviewSql.swift
//  BurgeRate
//
//  Created by MS-VM on 08/03/2019.
//  Copyright © 2019 MS-VM. All rights reserved.
//

import Foundation

extension Review{
    
    static func createTable(database: OpaquePointer?)  {
        var errormsg: UnsafeMutablePointer<Int8>? = nil
        let res = sqlite3_exec(database, "CREATE TABLE IF NOT EXISTS Reviews (REST TEXT, USER STRING, CAPTION TEXT, RATE INT, IMAGE TEXT, DATE DATE)", nil, nil, &errormsg);
        if(res != 0){
            print("error creating table");
            return
        }
    }
    
    static func getAll(database: OpaquePointer?)->[Review]{
        var sqlite3_stmt: OpaquePointer? = nil
        var data = [Review]()
        if (sqlite3_prepare_v2(database,"SELECT * from Review;",-1,&sqlite3_stmt,nil)
            == SQLITE_OK){
            while(sqlite3_step(sqlite3_stmt) == SQLITE_ROW){
                let rest = String(cString:sqlite3_column_text(sqlite3_stmt,1)!)
                let user = String(cString:sqlite3_column_text(sqlite3_stmt,2)!)
                let caption = String(cString:sqlite3_column_text(sqlite3_stmt,3)!)
                let rate = Int(String(cString:sqlite3_column_text(sqlite3_stmt,4)!))
                let image = String(cString:sqlite3_column_text(sqlite3_stmt,5)!)
                let date = String(cString:sqlite3_column_text(sqlite3_stmt,6)!).toDate(dateFormat: "dd-MM")
                data.append(Review(_rest: rest, _user: user, _rank: rate!, _caption: caption, _url: image, _date: date!))
            }
        }
        sqlite3_finalize(sqlite3_stmt)
        return data
    }
    
    static func addNew(database: OpaquePointer?, rv:Review){
        var sqlite3_stmt: OpaquePointer? = nil
        if (sqlite3_prepare_v2(database,"INSERT OR REPLACE INTO Reviews (REST, USER, CAPTION, RATE, IMAGE, DATE) VALUES (?,?,?,?,?,?);",-1, &sqlite3_stmt,nil) == SQLITE_OK){
            let rest = rv.Restaurant.cString(using: .utf8)
            let user = rv.User.cString(using: .utf8)
            let caption = rv.Caption.cString(using: .utf8)
            let rate = String(rv.Rank)
            let image = rv.URL.cString(using: .utf8)
            let date = rv.Date?.toString(dateFormat : "dd-MM").cString(using: .utf8)
            
            sqlite3_bind_text(sqlite3_stmt, 1, rest, -1,nil);
            sqlite3_bind_text(sqlite3_stmt, 2, user,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 3, caption,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 4, rate,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 5, image,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 6, date,-1,nil);
            if(sqlite3_step(sqlite3_stmt) == SQLITE_DONE){
                print("new row added succefully")
            }
        }
        sqlite3_finalize(sqlite3_stmt)
    }
    
    static func get(database: OpaquePointer?, byId:String)->Review?{
        
        return nil;
    }
}
