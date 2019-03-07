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
    @IBOutlet weak var noImageError: UILabel!
    @IBOutlet weak var CaptionError: UILabel!
    @IBOutlet weak var RestError: UILabel!
    
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
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        imageToUpload = info[UIImagePickerController.InfoKey.originalImage]! as? UIImage
        imageView.image = imageToUpload
        self.dismiss(animated: true, completion: nil)
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
    }
    
    public func IsInputValid () -> Bool{
        if (self.rest.text! != ""){
            self.RestError.text = ""
            if (self.caption.text! != ""){
                self.CaptionError.text = ""
                if (self.imageView.image != nil){
                    self.noImageError.text = ""
                    return true
                }
                else{
                    self.noImageError.text = "What's the point with no Pic?"
                }
            }
            else{
                self.CaptionError.text = "We realy want to hear, Pls!"
            }
        }
        else{
            self.RestError.text = "Why won't you tell us where did you eat? :("
        }
        return false

    }
    
    @IBAction func Save(_ sender: UIButton) {
        if (self.IsInputValid() == true) {
            if (imageView != nil){
                let date = Date()
                let name = rest!.text! + date.toString(dateFormat: "MMddHHmm")
                Model.instance.saveImage(image: imageToUpload!, name: name){ (url:String?) in
                    var _url = ""
                    if url != nil {
                        _url = url!
                    }
                    self.saveReviewInfo(url: _url)
                }
            }
            else{
                let alert = UIAlertController(title: "Oops", message: "Guess Something's went wrong. Care to try again later PLS?", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "K Bye", style: .default) {_ in print("You Clicked OK")}
                alert.addAction(okAction)
                self.present(alert, animated : true, completion: nil)
            }
        }
    }
    
    func saveReviewInfo(url:String)  {
        let user = Model.instance.loggedInUser
        let rv = Review(_rest: rest.text!, _user: user.Username, _rank: rate!.selectedSegmentIndex , _caption: caption.text!, _url: url, _date: date.date)
        
        Model.instance.addNewReview(review: rv)
        self.popMsgSuccess()
        self.navigationController?.popViewController(animated: true)
    }
    
    func popMsgSuccess() {
        let alert = UIAlertController(title: "Great", message: "Your review was successfully added! ", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Check Feed", style: .default) {_ in print("moved to feed")}
        alert.addAction(okAction)
        self.present(alert, animated : true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
