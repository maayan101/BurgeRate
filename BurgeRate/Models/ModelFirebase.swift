//
//  ModelFirebase.swift
//  BurgeRate
//
//  Created by MS-VM on 16/01/2019.
//  Copyright © 2019 MS-VM. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage

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
        //ref.child("reviews").child(review.RevID).setValue(review.toJson())
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
    
    lazy var storageRef = Storage.storage().reference(forURL:
        "gs://burgerate-89ca7.appspot.com/")
    
    func saveImage(image:UIImage, name:(String),
                   callback:@escaping (String?)->Void){
        let data = image.jpegData(compressionQuality: 0.8)
        let imageRef = storageRef.child(name)
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        imageRef.putData(data!, metadata: metadata) { (metadata, error) in
            imageRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    // Uh-oh, an error occurred!
                    return
                }
                print("url: \(downloadURL)")
                callback(downloadURL.absoluteString)
            }
        }
    }
    
    func getImage(url:String, callback:@escaping (UIImage?)->Void){
        let ref = Storage.storage().reference(forURL: url)
        ref.getData(maxSize: 10 * 1024 * 1024) { data, error in
            if error != nil {
                callback(nil)
            } else {
                let image = UIImage(data: data!)
                callback(image)
            }
        }
    }
    
    
}











