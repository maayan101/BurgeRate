//
//  AddReviewViewController.swift
//  BurgeRate
//
//  Created by MS-VM on 06/02/2019.
//  Copyright © 2019 MS-VM. All rights reserved.
//

import Foundation
import UIKit

class AddReviewViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var image:UIImage?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idTextBox: UITextField!
    @IBOutlet weak var nameTextBox: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func takeImage(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self //as!  & UINavigationControllerDelegate
            imagePicker.sourceType = UIImagePickerController.SourceType.camera;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }else{
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType =
                UIImagePickerController.SourceType.photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    // UIImagePickerControllerDelegate
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        image = info["UIImagePickerControllerOriginalImage"] as? UIImage
        imageView.image = image
        self.dismiss(animated: true, completion: nil)
    }
    
    
    /*
    @IBAction func save(_ sender: UIButton) {
        if image != nil {
            Model.instance.saveImage(image: image!, name: nameTextBox.text!){ (url:String?) in
                var _url = ""
                if url != nil {
                    _url = url!
                }
                self.saveStudentInfo(url: _url)
            }
        }else{
            self.saveStudentInfo(url: "")
        }
    }
    
    func saveStudentInfo(url:String)  {
        let st = User(_id: idTextBox.text!, _name: nameTextBox.text!, _phone:"9999", _url:url)
        Model.instance.addNewStudent(student: st)
        self.navigationController?.popViewController(animated: true)
    }
    */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
