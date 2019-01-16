//
//  User.swift
//  BurgeRate
//
//  Created by MS-VM on 16/01/2019.
//  Copyright © 2019 MS-VM. All rights reserved.
//

import Foundation

class User{
    let UserID:String
    let Username:String
    let Email:String
    let Password:String
    let Gender:String
    
    init( _id:String, _username:String, _password:String, _email:String, _gender:String ) {
        UserID = _id
        Email = _email
        Password = _password
        Gender = _gender
        Username = _username
    }
    
}
