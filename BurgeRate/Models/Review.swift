//
//  Review.swift
//  BurgeRate
//
//  Created by MS-VM on 16/01/2019.
//  Copyright © 2019 MS-VM. All rights reserved.
//

import Foundation
class Review{
    let RevID:String
    let Restaurant:String
    let User:String
    let Rank:String
    let Caption:String
    
    init(_rest:String, _user:String, _rank:String, _caption:String, _id:String) {
        RevID = _id
        Restaurant = _rest
        User = _user
        Rank = _rank
        Caption = _caption
    }

    init(json:[String:Any]){
        RevID = json["revid"] as! String
        Restaurant = json["restaurant"] as! String
        User = json["user"] as! String
        Rank = json["rank"] as! String
        Caption = json["caption"] as! String
    }
    
    func toJson()-> [String:Any]{
        var json = [String:Any]()
        json["revid"] = RevID
        json["restaurant"] = Restaurant
        json["user"] = User
        json["rank"] = Rank
        json["caption"] = Caption
        return json
    }
}
