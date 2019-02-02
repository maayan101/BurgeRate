//
//  User.swift
//  BurgeRate
//
//  Created by MS-VM on 16/01/2019.
//  Copyright © 2019 MS-VM. All rights reserved.
//

import Foundation

class User{
    //let UserID:String
    let Username:String
    let Email:String
    let Password:String
    let Gender:String
    
    init( //_id:String,
        _username:String, _password:String, _email:String, _gender:String ) {
        //UserID = _id
        Email = _email
        Password = _password
        Gender = _gender
        Username = _username
    }
    init(json:[String:Any]){
        //UserID = json["id"] as! String
        Email = json["email"] as! String
        Password = json["password"] as! String
        Gender = json["gender"] as! String
        Username = json["username"] as! String
    }
    func toJson()-> [String:Any]{
        var json = [String:Any]()
        //json["id"] = UserID
        json["email"] = Email
        json["password"] = Password
        json["gender"] = Gender
        json["username"] = Username
        return json
      }
   
}

