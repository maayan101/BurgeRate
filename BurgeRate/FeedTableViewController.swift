//
//  FeedTableViewController.swift
//  BurgeRate
//
//  Created by Maayan Sidon on 30/01/2019.
//  Copyright © 2019 MS-VM. All rights reserved.
//

import Foundation
import UIKit


class FeedTableViewController: UITableViewController {
    var data = [Review]()
    var ReviewListener:NSObjectProtocol?
    var vSpinner : UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ReviewListener = ModelNotification.ReviewListNotification.observe(){
            (data:Any) in
            self.data = data as! [Review]
            self.tableView.reloadData()
        }
        
     //   vSpinner = self.showSpinner(onView: self.view)
        Model.instance.getAllReviews(){
            if (self.data.count != 0){
                self.removeSpinner(vSpinner: self.vSpinner!)
            }
            else{
                self.popMsgFail()
            }
        }
    }
    
    deinit{
        if ReviewListener != nil{
            ModelNotification.ReviewListNotification.remove(observer: ReviewListener!)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func popMsgFail(){
        let alert = UIAlertController(title: "Oops", message: "Guess Something's went wrong. So sorry :(", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "K Bye", style: .default) {_ in print("You Clicked OK")}
        alert.addAction(okAction)
        self.present(alert, animated : true, completion: nil)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 256
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ReviewTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath) as! ReviewTableViewCell
        
        let rv = data[indexPath.row]
        cell.Restaurant.text = rv.Restaurant
        let rank : String = String (describing : rv.Rank)
        cell.Stars.text = rank + "/5 Stars"
        cell.User.text = "by " + rv.User
        cell.Caption.text = rv.Caption
        cell.imageView?.image = UIImage(named: "avatar")
        cell.imageView!.tag = indexPath.row
        if rv.URL != "" {
            Model.instance.getImage(url: rv.URL) { (image:UIImage?) in
                if (cell.imageView!.tag == indexPath.row){
                    if image != nil {
                        cell.imageView?.image = image!
                    }
                }
            }
        }
        
        return cell
    }
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
 */
    
}

