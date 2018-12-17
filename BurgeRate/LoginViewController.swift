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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

