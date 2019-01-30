//
//  Model.swift
//  BurgeRate
//
//  Created by MS-VM on 16/01/2019.
//  Copyright © 2019 MS-VM. All rights reserved.
//

import Foundation

class Model {
    static let instance:Model = Model()
    
    let usersListNotification = ""
    
    //var modelSql:ModelSql?
    var modelFirebase = ModelFirebase();
    
    private init(){
        //modelSql = ModelSql()
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
    
    func addNewUser(user:User){
        modelFirebase.addNewUser(user:user);
        //Student.addNew(database: modelSql!.database, student: student)
    }
    
    func getStudent(byId:String)->User?{
        return modelFirebase.getUser(byId:byId)
        //return Student.get(database: modelSql!.database, byId: byId);
    }
    
    func getAllReviewss(callback:@escaping ([Review])->Void){
        ModelFirebase.getAllReviews(callback: callback);
    }
    
    class ModelNotification{
        static let studentsListNotification = MyNotification<[Review]>("com.menachi.studentlist")
        
        class MyNotification<T>{
            let name:String
            var count = 0;
            
            init(_ _name:String) {
                name = _name
            }
            func observe(cb:@escaping (T)->Void)-> NSObjectProtocol{
                count += 1
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
                count -= 1
                NotificationCenter.default.removeObserver(observer, name: nil, object: nil)
            }
            
            
        }
        
    }

}

