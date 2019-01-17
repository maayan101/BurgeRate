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
    @IBOutlet weak var Stars: UILabel!
    @IBOutlet weak var Caption: UILabel!
    @IBOutlet weak var User: UILabel!
    @IBOutlet weak var url: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
