//
//  MyFeedTableViewController.swift
//  BurgeRate
//
//  Created by MS-VM on 09/03/2019.
//  Copyright © 2019 MS-VM. All rights reserved.
//

import Foundation
import UIKit


class MyFeedTableViewController: UITableViewController {
    var data = [Review]()
    var ReviewListener:NSObjectProtocol?
    var vSpinner : UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ReviewListener = ModelNotification.ReviewListNotification.observe(){
            (data:Any) in
            self.data = data as! [Review]
            self.tableView.reloadData()
            self.vSpinner?.removeFromSuperview()
        }
        
        vSpinner = self.showSpinner(onView: self.view)
        Model.instance.getMyReviews()
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
        Model.instance.getUser(byId: rv.User){(userByMail) in
            if (userByMail != nil)
            {
                cell.User.text = "by " + userByMail!.Username
            }
            else
            {
                cell.User.text = "by Anonymous"
            }}
        
        cell.Caption.text = rv.Caption
        cell.url.image = UIImage(named: "avatar")
        cell.url.tag = indexPath.row
        if rv.URL != "" {
            Model.instance.getImage(url: rv.URL) { (image:UIImage?) in
                if (cell.url.tag == indexPath.row){
                    if image != nil {
                        cell.url.image = image!
                    }
                }
            }
        }
        cell.Delete.setTitle("Delete", for: UIControl.State.normal)
        cell.revId.text! = rv.RevID!
        return cell
    }

}

