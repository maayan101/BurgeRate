//
//  MyProfileViewController.swift
//  BurgeRate
//
//  Created by maya preschel on 07/03/2019.
//  Copyright © 2019 MS-VM. All rights reserved.
//

import Foundation
import UIKit


class MyProfileViewController: UIViewController {
//    var data = [Review]()
//    var ReviewListener:NSObjectProtocol?
    
    @IBOutlet weak var UsernameUpdateText: UITextField!
    @IBOutlet weak var GenderUpdagteSeg: UISegmentedControl!
    @IBOutlet weak var UsernameUpdateVal: UILabel!
    
    func validateUsername(username: String) -> Bool {
        if username == "" {
            UsernameUpdateVal.text = "Username can't be empty"
            return false
        }
        if username.count < 5 {
            UsernameUpdateVal.text = "Username can't be less then 5 characters"
            return false
        }
        
        if username.count > 20 {
            UsernameUpdateVal.text = "Username can't be more then 20 characters"
            return false
        }
        
        UsernameUpdateVal.text = ""
        return true
    }
    
    @IBAction func UpdateUser(_ sender: Any) {
        if validateUsername(username: UsernameUpdateText.text!) {
            Model.instance.updateUser(username: UsernameUpdateText.text!, gender: GenderUpdagteSeg.selectedSegmentIndex) { (success) in
                if success {
                    let alertController = UIAlertController(title: "User Update", message:
                        "User updated successfully", preferredStyle: UIAlertController.Style.alert)
                    alertController.addAction(UIAlertAction(title: "Back", style: UIAlertAction.Style.default,handler: nil))
                    self.present(alertController, animated: true, completion: nil)
                    sleep(1)
                    Model.instance.updateCurrentUser()
                    sleep(1)
                    
                } else {
                    let alertController = UIAlertController(title: "User Update", message:
                        "User update failed", preferredStyle: UIAlertController.Style.alert)
                    alertController.addAction(UIAlertAction(title: "Back", style: UIAlertAction.Style.default,handler: nil))
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    @IBAction func LogOutUser(_ sender: Any) {
        Model.instance.logout()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.afterLogout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UsernameUpdateText.text == "" {
            sleep(1)
            let user = Model.instance.loggedInUser
            UsernameUpdateText.text = user.Username
            GenderUpdagteSeg.selectedSegmentIndex = user.Gender
        }
    }
    
    deinit{
//        if ReviewListener != nil{
//            ModelNotification.ReviewListNotification.remove(observer: ReviewListener!)
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
    
}
