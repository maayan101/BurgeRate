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
    var imageToUpload:UIImage?
    
    @IBOutlet weak var rest: UITextField!
    @IBOutlet weak var date: UIDatePicker!
    @IBOutlet weak var rate: UISegmentedControl!
    @IBOutlet weak var caption: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var noImageWarning: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func ChooseImage(_ sender: Any) {
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
        imageToUpload = info["UIImagePickerControllerOriginalImage"] as? UIImage
        imageView.image = imageToUpload
        self.dismiss(animated: true, completion: nil)
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
    }
    
    @IBAction func Save(_ sender: UIButton) {
        if imageToUpload != nil {
            let date = Date()
            let name = rest!.text! + date.toString(dateFormat: "MMddHHmm")
            Model.instance.saveImage(image: imageToUpload!, name: name){ (url:String?) in
                var _url = ""
                if url != nil {
                    _url = url!
                }
                self.saveReviewInfo(url: _url)
            }
        }else{
            self.noImageWarning.isHidden = false
        }
    }
    
    func saveReviewInfo(url:String)  {
        let rv = Review(_rest: rest.text!, _user: "gevermelech", _rank: rate!.selectedSegmentIndex , _caption: caption.text!, _url: url, _date: date.date)
        
        Model.instance.addNewReview(review: rv)
        self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
