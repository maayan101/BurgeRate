//
//  Review.swift
//  BurgeRate
//
//  Created by MS-VM on 16/01/2019.
//  Copyright © 2019 MS-VM. All rights reserved.
//

import Foundation
class Review{
    let ID:String
    let Restaurant:String
    let User:String
    let Rank:String
    let Caption:String
    
    init(_rest:String, _user:String, _rank:String, _caption:String, _id:String) {
        ID = _id
        Restaurant = _rest
        User = _user
        Rank = _rank
        Caption = _caption
    }
    
}
