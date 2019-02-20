//
//  SignUpViewController.swift
//  BurgeRate
//
//  Created by MS-VM on 16/12/2018.
//  Copyright © 2018 MS-VM. All rights reserved.
//

import Foundation
import UIKit

protocol SignUpControllerDelegate{
    func onComplete(success:Bool);
}


class SignUpViewController: UIViewController {
    var titleMessage:String?
    var delegate:SignUpControllerDelegate?
    
    @IBOutlet weak var viewTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let msg = titleMessage{
            self.viewTitle.text = msg;
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBOutlet weak var UserNameText: UITextField!
    @IBOutlet weak var PasswordText: UITextField!
    @IBOutlet weak var GenderSeg: UISegmentedControl!
    @IBOutlet weak var EmailText: UITextField!
    @IBOutlet weak var UsernameVal: UILabel!
    @IBOutlet weak var PasswordVal: UILabel!
    @IBOutlet weak var EmailVal: UILabel!
    @IBOutlet weak var GenderVal: UILabel!
    
    func validateUsername(username: String) -> Bool {
        if username == "" {
            UsernameVal.text = "Username can't be empty"
            return false
        }
        if username.count < 5 {
            UsernameVal.text = "Username can't be less then 5 characters"
            return false
        }
        
        if username.count > 20 {
            UsernameVal.text = "Username can't be more then 20 characters"
            return false
        }
        
        return true
    }
    func validatePassword(password: String) -> Bool {
        if password == "" {
            PasswordVal.text = "Password can't be empty"
            return false
        }
        if password.count < 6 {
            PasswordVal.text = "Password can't be less then 6 characters"
            return false
        }
        
        if password.count > 20 {
            PasswordVal.text = "Password can't be more then 20 characters"
            return false
        }
        
        return true
    }
    func isValidEmail(email:String) -> Bool {
        if email == "" {
            EmailVal.text = "Email address can't be empty"
            return false
        }
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        if emailTest.evaluate(with: email) == false {
            EmailVal.text = "Email address isn't valid"
            return false
        }
        
        return true
        
    }
    
    func isFormValid(username:String, password:String, email:String, gender:String) -> Bool {
        let valUsernameResult = validateUsername(username: username)
        let valPasswordResult = validatePassword(password: password)
        let valEmailResult = isValidEmail(email: email)
        
        if valUsernameResult && valEmailResult && valPasswordResult {
            return true
        }
        
        return false
    }

    @IBAction func SignUp(_ sender: UIButton) {
        if isFormValid(username: UserNameText.text!, password: PasswordText.text!, email: EmailText.text!, gender: "Male") {
            let user = User(_username: UserNameText.text!, _password: PasswordText.text!, _email:EmailText.text!,_gender :    GenderSeg.titleForSegment(at: GenderSeg.selectedSegmentIndex)!)
            Model.instance.addNewUser(User: user, email: user.Email, password: user.Password) { (success) in
                if success {
                    self.navigationController?.popViewController(animated: true)
                } else {
                    self.EmailVal.text = "Email address already exists"
                }
            }
            
            
        }
    }
    
    @IBAction func back(_ sender: UIButton) {
        if self.delegate != nil{
            self.delegate!.onComplete(success: true);
        }
        if self.navigationController != nil {
            self.navigationController!.popViewController(animated: true);
        }else{
            self.dismiss(animated: true, completion: nil);
        }
    }
    
    @IBAction func manualBack(_ sender: UIButton) {
        if self.delegate != nil{
            self.delegate!.onComplete(success: false);
        }
        self.performSegue(withIdentifier: "backFromSignUp", sender: self)}

}
