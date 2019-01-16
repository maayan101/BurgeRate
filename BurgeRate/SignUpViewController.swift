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
    @IBOutlet weak var EmailText: UITextField!
    @IBOutlet weak var GenderSeg: UISegmentedControl!
    
    @IBAction func SignUp(_ sender: UIButton) {
        let user = User(_id: 1, _username: UserNameText.text!, _password: <#String#>, )
        Model.instance.addNewStudent(student: st)
        self.navigationController?.popViewController(animated: true)
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
