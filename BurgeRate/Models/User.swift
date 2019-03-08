//
//  User.swift
//  BurgeRate
//
//  Created by MS-VM on 16/01/2019.
//  Copyright © 2019 MS-VM. All rights reserved.
//

import Foundation
import FirebaseDatabase

class User{
    let Username:String
    let Email:String
    let Password:String
    let Gender:Int
    var LastUpdate:Date?
    
    init(_username:String, _password:String, _email:String, _gender:Int) {
        Email = _email
        Password = _password
        Gender = _gender
        Username = _username
    }
    init(json:[String:Any]) {
        Email = json["email"] as! String
        Password = json["password"] as! String
        Gender = json["gender"] as! Int
        Username = json["username"] as! String
        if let ts = json["lastUpdate"] as? Double{
            self.LastUpdate = Date.fromFirebase(ts)
        }
    }
    func toJson()-> [String:Any]{
        var json = [String:Any]()
        //json["id"] = UserID
        json["email"] = Email
        json["password"] = Password
        json["gender"] = Gender
        json["username"] = Username
        json["lastUpdate"] = ServerValue.timestamp()
        return json
      }
   
}

