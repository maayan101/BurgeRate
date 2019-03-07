//
//  LoginViewController.swift
//  BurgeRate
//
//  Created by MS-VM on 16/12/2018.
//  Copyright © 2018 MS-VM. All rights reserved.
//

import Foundation
import UIKit

protocol LoginControllerDelegate{
    func onComplete(success:Bool);
}


class LoginViewController: UIViewController {
    var delegate:LoginControllerDelegate?

    @IBOutlet weak var EmailLoginText: UITextField!
    @IBOutlet weak var PasswordLoginText: UITextField!
    @IBOutlet weak var LoginVal: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Signin(_ sender: Any) {
        Model.instance.signin(email: EmailLoginText.text!, password: PasswordLoginText.text!) { (success) in
            if success {
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.afterLogin()
            } else {
                self.LoginVal.text = "Email address or Password is incorrect"
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
        self.performSegue(withIdentifier: "backFromSignUp", sender: self)
        
}
    
}

