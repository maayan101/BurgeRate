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
}

