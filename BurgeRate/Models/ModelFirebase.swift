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
import FirebaseAuth

class ModelFirebase {
    var ref: DatabaseReference!
    
    init() {
        FirebaseApp.configure()
        ref = Database.database().reference()
        
    }
    
    func signin(email:String, password:String, callback:@escaping (Bool)->Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if (user != nil){
                //user?.user.uid
                callback(true)
            }else{
                callback(false)
            }
        }
    }
    
    func logout(){
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    func updateUser(User: User, callback:@escaping (Bool) -> Void) {
        let email = User.Email
        let newEmail = email.replacingOccurrences(of: ".", with: "", options: NSString.CompareOptions.literal, range: nil)
        self.ref.child("users").child(newEmail).setValue(User.toJson())
 
        callback(true)
    }
    
    func createUser(User: User, email:String, password:String, callback:@escaping (Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if error != nil {
                callback(false)
            } else {
                let email = User.Email
                let newEmail = email.replacingOccurrences(of: ".", with: "", options: NSString.CompareOptions.literal, range: nil)
                self.ref.child("users").child(newEmail).setValue(User.toJson())
                
                callback(true)
            }
        }
    }
    
    func updateUserWork(email: String, password: String, username: String, gender: Int, callback:@escaping (Bool) -> Void) {
        let newEmail = email.replacingOccurrences(of: ".", with: "", options: NSString.CompareOptions.literal, range: nil)
        let user = User(_username: username, _password: password, _email: email, _gender: gender)
        self.ref.child("users").child(newEmail).setValue(user.toJson())
        callback(true)
    }

    
    func getUser(byId:String) -> User?{
        return User(json: (ref.child("users").child(byId).value(forKey: byId) as? [String: Any])!)
    }
    
    func getUser(byId2 :String) -> String?{
        return  ref.child("users").child(byId2).value(forKey: "username") as? String
    }
    
    /*
    func isExistsUserByUsername(username:String)->Bool{
        let isExists = true
        return ref.child("users").queryOrdered(byChild: "username").queryEqual(toValue: username).observe(., with: { (snapshot) in
            if snapshot.exists() {
                 isExists = true
            }
            else {
                isExists = false
            }
        })
        return isExists
    }
    */
    
    func addNewReview(review:Review ,callback:@escaping (Bool)->Void){
        ref.child("reviews").childByAutoId().setValue(review.toJson()) { (error, ref) in
            if (error != nil){
                print(error?.localizedDescription as Any)
                callback(true)
            }
            else{
                callback(false)
            }
        }
    }
    
    func getAllReviews(callback:@escaping ([Review])->Void){
        ref.child("reviews").observe(.value, with: {
            (snapshot) in
            var data = [Review]()
            // Get review value
            let value = snapshot.value as! [String:Any]
            for (key, json) in value{
                /*var newJson = [String:Any]()
                newJson["restaurant"] = json["restaurant"]
                newJson["user"] = json["user"]
                newJson["rank"] = json["rank"]
                newJson["caption"] = json["caption"]
                newJson["url"] = json["url"]
                newJson["date"] = json["date"]
                newJson["key"] = key*/
                let rv = Review(json: json as! [String : Any])
                rv.addKey(key: key)
                data.append(rv)
            }
            callback(data)
        })
     }
    
    func getMyReviews(byId: String, callback:@escaping ([Review])->Void){
        ref.child("reviews").observe(.value, with: {
            (snapshot) in
            var data = [Review]()
            // Get review value
            let value = snapshot.value as! [String:Any]
            for (key, json) in value{
                let rv = Review(json: json as! [String : Any])
                if (rv.User == byId){
                    rv.addKey(key: key)
                    data.append(rv)}
            }
            callback(data)
        })
    }
    
    func RemoveReview(key: String, callback:@escaping (Bool) -> Void)
    {
        ref.child("reviews").child(key).removeValue()
        callback(true)
    }

    func getAllUsers(callback:@escaping ([User])->Void){
        ref.child("users").observe(.value, with: {
            (snapshot) in
            // Get review value
            var data = [User]()
            let value = snapshot.value as! [String:Any]
            for (_, json) in value{
                data.append(User(json: json as! [String : Any]))
            }
            callback(data)
        })
    }
    
    func getCurrentUserEmail() -> String? {
        return Auth.auth().currentUser?.email
    }
    
    func getUsersByEmail(email: String, callback:@escaping ([User])->Void){
        ref.child("users").observe(.value, with: {
            (snapshot) in
            // Get review value
            var data = [User]()
            let value = snapshot.value as! [String: Any]
            for (_, json) in value{
                if User(json: json as! [String: Any]).Email == email {
                    data.append(User(json: json as! [String: Any]))
                }
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
        
        /*ref.child(url).getData(maxSize: 10 * 1024 * 1024) { (data, error) -> Void in
            
            if (error != nil) {
                
                print(error!.localizedDescription)
                
            } else {
                
                let image = UIImage(data: data!)
                print("– – – Succesfully downloaded the shared profile picture")
                callback(image)
            }
            
            
        }*/
        
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











