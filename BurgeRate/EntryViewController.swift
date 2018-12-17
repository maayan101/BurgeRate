//
//  ViewController.swift
//  BurgeRate
//
//  Created by MS-VM on 16/12/2018.
//  Copyright © 2018 MS-VM. All rights reserved.
//

import UIKit

class EntryViewController: UIViewController, SignUpControllerDelegate {
    
    func onComplete(success: Bool) {
        NSLog("SignUp delegate returned \(success)");
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func signin(_ sender: UIButton) {
        self.performSegue(withIdentifier: "SignUp", sender: self);

    }
    
    @IBAction func login(_ sender: UIButton) {
    }
    
    
    @IBAction func backFromSignUp(segue:UIStoryboardSegue){
        NSLog("back from SignUp function called");
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SignUp" {
            let suvc:SignUpViewController = segue.destination as! SignUpViewController
            suvc.delegate = self ;
        }
        if segue.identifier == "Login" {
            let livc:LoginViewController = segue.destination as! LoginViewController
            livc.delegate = self as? LoginControllerDelegate ;
        }
    }
    
}




