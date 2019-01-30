//
//  ModelFirebase.swift
//  BurgeRate
//
//  Created by MS-VM on 16/01/2019.
//  Copyright © 2019 MS-VM. All rights reserved.
//

import Foundation

import Firebase
import FirebaseDatabase

class ModelFirebase {
    var ref: DatabaseReference!
    
    init() {
        FirebaseApp.configure()
        ref = Database.database().reference()
        
    }
    
   /* func getAllStudents(callback:@escaping ([Student])->Void){
        //        ref.child("students").observeSingleEvent(of: .value, with: { (snapshot) in
        //            // Get user value
        //            var data = [Student]()
        //            let value = snapshot.value as! [String:Any]
        //            for (_, json) in value{
        //                data.append(Student(json: json as! [String : Any]))
        //            }
        //            callback(data)
        //        }) { (error) in
        //            print(error.localizedDescription)
        //        }
        
        ref.child("students").observe(.value, with: {
            (snapshot) in
            // Get user value
            var data = [Student]()
            let value = snapshot.value as! [String:Any]
            for (_, json) in value{
                data.append(Student(json: json as! [String : Any]))
            }
            callback(data)
        })
    }
    */
    func addNewUser(user:User){
        ref.child("users").child(user.UserID).setValue(user.toJson())
    }
    
    func getUser(byId:String)->User?{
        return nil
    }
    
    func addNewReview(review:Review){
        ref.child("reviews").child(review.RevID).setValue(review.toJson())
    }
    
    func getAllReviews(callback:@escaping ([Review])->Void){
        ref.child("reviews").observe(.value, with: {
            (snapshot) in
            // Get review value
            var data = [Review]()
            let value = snapshot.value as! [String:Any]
            for (_, json) in value{
                data.append(Review(json: json as! [String : Any]))
            }
            callback(data)
        })
     }
    
}











