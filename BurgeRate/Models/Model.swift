//
//  Model.swift
//  BurgeRate
//
//  Created by MS-VM on 16/01/2019.
//  Copyright © 2019 MS-VM. All rights reserved.
//

import Foundation
import UIKit

class Model {
    static let instance:Model = Model()
    
    let reviewsListNotification = ""
    
    //var modelSql:ModelSql?
    var modelFirebase = ModelFirebase();
    
    private init(){
        //modelSql = ModelSql()
    }
    
    func addNewUser(User: User, email: String, password: String, callback:@escaping (Bool)->Void) {
        return modelFirebase.createUser(User: User, email: email, password: password, callback: callback)
    }
  /*  func getAllUsers() {
        ModelFirebase.getAllStudents(callback: {(data:[User]) in
            NotificationCenter.default.post(name: NSNotification.Name(self.usersListNotification),
                                            object: self,
                                            userInfo: ["data":data])
            
        })
    }
    
    func getAllStudents(callback:@escaping ([User])->Void){
        ModelFirebase.getAllUsers(callback: callback);
        //return Student.getAll(database: modelSql!.database);
    }
    */
    
    /*func addNewUser(user:User){
        modelFirebase.addNewUser(user:user);
        //Student.addNew(database: modelSql!.database, student: student)
    }*/
    
    func getUser(byId:String) -> User? {
        return modelFirebase.getUser(byId: byId)
        //return Student.get(database: modelSql!.database, byId: byId);
    }
    
    func getAllReviews() {
        modelFirebase.getAllReviews(callback: {(data:[Review]) in
            ModelNotification.ReviewListNotification.notify(data: data)
        })
    }
    
    /*func getAllReviews() {
        modelFirebase.getAllReviews(callback: {(data:[Review]) in
            NotificationCenter.default.post(name: NSNotification.Name(self.reviewsListNotification),
                                            object: self,
                                            userInfo: ["data":data])
            
        })
    }*/
    
    func saveImage(image:UIImage, name:(String),callback:@escaping (String?)->Void){
        modelFirebase.saveImage(image: image, name: name, callback: callback)
        
    }
    
    func getImage(url:String, callback:@escaping (UIImage?)->Void){
        //1. try to get the image from local store
        let _url = URL(string: url)
        let localImageName = _url!.lastPathComponent
        
        if let image = self.getImageFromFile(name: localImageName){
            callback(image)
            print("got image from cache \(localImageName)")
        }else{
            //2. get the image from Firebase
            self.modelFirebase.getImage(url: url){(image:UIImage?) in
                if (image != nil){
                    //3. save the image localy
                    self.saveImageToFile(image: image!, name: localImageName)
                }
                //4. return the image to the user
                callback(image)
                print("got image from firebase \(localImageName)")
            }
        }
    }
    
    
    /// File handling
    func saveImageToFile(image:UIImage, name:String){
        if let data = image.jpegData(compressionQuality: 0.8)  {
            let filename = getDocumentsDirectory().appendingPathComponent(name)
            try? data.write(to: filename)
        }
    }
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in:
            .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func getImageFromFile(name:String)->UIImage?{
        let filename = getDocumentsDirectory().appendingPathComponent(name)
        return UIImage(contentsOfFile:filename.path)
    }

}
    class ModelNotification{
        static let ReviewListNotification = MyNotification<[Review]>(_name: "com.BurgeRate.reviewlist")
        
        class MyNotification<T>{
            let name:String
            init(_name:String) {
                name = _name
            }
            func observe(cb:@escaping (T)->Void)-> NSObjectProtocol{

                return NotificationCenter.default.addObserver(forName: NSNotification.Name(name),
                                                              object: nil, queue: nil) { (data) in
                                                                if let data = data.userInfo?["data"] as? T {
                                                                    cb(data)
                                                                }
                }
            }
            
            func notify(data:T){
                NotificationCenter.default.post(name: NSNotification.Name(name),
                                                object: self,
                                                userInfo: ["data":data])
            }
            
            func remove(observer: NSObjectProtocol){
                NotificationCenter.default.removeObserver(observer, name: nil, object: nil)
            }
            
            
        }
        
    }



