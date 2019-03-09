//
//  ReviewTableViewCell.swift
//  BurgeRate
//
//  Created by MS-VM on 16/01/2019.
//  Copyright © 2019 MS-VM. All rights reserved.
//

import Foundation
import UIKit
class ReviewTableViewCell : UITableViewCell
{
    @IBOutlet weak var Restaurant: UILabel!
    @IBOutlet weak var url: UIImageView!
    @IBOutlet weak var Stars: UILabel!
    @IBOutlet weak var Caption: UILabel!
    @IBOutlet weak var User: UILabel!
    @IBOutlet weak var Delete: UIButton!
    
    @IBOutlet weak var revId: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func DeleteReview(_ sender: Any) {
        Model.instance.removeReview(revId: revId.text!) { (didSuc) in
            if (didSuc != true){
                self.Delete.titleLabel?.text = "Try Later."
                self.Delete.isEnabled = false
            }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
