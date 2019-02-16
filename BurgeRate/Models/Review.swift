//
//  Review.swift
//  BurgeRate
//
//  Created by MS-VM on 16/01/2019.
//  Copyright © 2019 MS-VM. All rights reserved.
//

import Foundation
class Review{
    let Restaurant:String
    let User:String
    let Rank: Int
    let Caption:String
    let URL:String
    var Date:Date?
    
    init(_rest:String, _user:String, _rank:Int, _caption:String, _url:String, _date:Date) {
        Restaurant = _rest
        User = _user
        Rank = _rank
        Caption = _caption
        URL = _url
        Date = _date
        
    }

    init(json:[String:Any]){
        Restaurant = json["restaurant"] as! String
        User = json["user"] as! String
        Rank = json["rank"] as! Int
        Caption = json["caption"] as! String
        URL = json["url"] as! String
        Date = (json["date"] as! String).toDate(dateFormat: "dd-MM")
    }
    
    func toJson()-> [String:Any]{
        var json = [String:Any]()
        json["restaurant"] = Restaurant
        json["user"] = User
        json["rank"] = Rank
        json["caption"] = Caption
        json["url"] = URL
        json["date"] = Date?.toString(dateFormat: "dd-MM")
        return json
    }
}

extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
}
extension String
{
    func toDate(dateFormat format  : String ) -> Date?
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
        let newDate = dateFormatter.date(from: "01-01-2017")
        return newDate
    }
}
