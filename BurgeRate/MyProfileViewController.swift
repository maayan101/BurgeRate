//
//  MyProfileViewController.swift
//  BurgeRate
//
//  Created by maya preschel on 07/03/2019.
//  Copyright © 2019 MS-VM. All rights reserved.
//

import Foundation
import UIKit


class MyProfileViewController: UITableViewController {
    var data = [Review]()
    var ReviewListener:NSObjectProtocol?
    
    @IBOutlet weak var UsernameUpdateText: UITextField!
    @IBOutlet weak var GenderUpdagteSeg: UISegmentedControl!
    
    @IBAction func UpdateUser(_ sender: Any) {
    }
    @IBAction func LogOutUser(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let user = Model.instance.loggedInUser
        UsernameUpdateText.text = user.Username
        
        //        Model.instance.signin(email: "eliav@temp.com", password: "1234567890") { (ret:Bool) in
        //            if (ret){
        //                print("create user success")
        //            }else{
        //                print("create user fail")
        //
        //            }
        //        }
    }
    
    deinit{
        if ReviewListener != nil{
            ModelNotification.ReviewListNotification.remove(observer: ReviewListener!)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}
