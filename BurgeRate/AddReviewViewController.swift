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
    var vSpinner : UIView?
    
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
        self.clearForm()
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
               self.popMsgFail()
            }
        }
    }
    
    func saveReviewInfo(url:String)  {
        let user = Model.instance.loggedInUser
        let rv = Review(_rest: rest.text!, _user: user.Email, _rank: rate!.selectedSegmentIndex + 1, _caption: caption.text!, _url: url, _date: date.date)
        
        vSpinner = self.showSpinner(onView: self.view)
        Model.instance.addNewReview(review: rv){(error) in
            if (error == false)
            {
                self.popMsgSuccess()
                self.removeSpinner(vSpinner: self.vSpinner!)
                self.clearForm()
            }
            else{
                self.popMsgFail()
            }
        }
    }
    
    func clearForm(){
        self.caption.text = ""
        self.rest.text = ""
        self.imageToUpload = nil
        self.imageView.image = nil
        self.rate.selectedSegmentIndex = 0
        self.RestError.text = ""
        self.noImageError.text = ""
        self.CaptionError.text = ""
    }
    
    func popMsgFail(){
        let alert = UIAlertController(title: "Oops", message: "Guess Something's went wrong. Care to try again later PLS?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "K Bye", style: .default) {_ in print("You Clicked OK")}
        alert.addAction(okAction)
        self.present(alert, animated : true, completion: nil)
    }
    
    func popMsgSuccess() {
        let alert = UIAlertController(title: "Great", message: "Your review was successfully added! ", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "K Tnx", style: .default) {_ in print("finished")}
        alert.addAction(okAction)
        self.present(alert, animated : true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension UIViewController {

    func showSpinner(onView : UIView) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        return spinnerView
    }
    
    func removeSpinner(vSpinner : UIView) -> Void{
        DispatchQueue.main.async {
            vSpinner.removeFromSuperview()
        }
    }
}
