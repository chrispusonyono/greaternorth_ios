//
//  FuelTableViewCell.swift
//  XcodeLoginExample
//
//  Created by Chrispus Onyono on 28/08/2017.
//  Copyright © 2017 Belal Khan. All rights reserved.
//

import UIKit

class FuelTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var gallons: UILabel!
    @IBOutlet weak var miles: UILabel!
    @IBOutlet weak var cost: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       // letBack.layer.cornerRadius = 10;
       // letBack.layer.masksToBounds = true;
        
       // righBack.layer.cornerRadius = 10;
       // righBack.layer.masksToBounds = true;
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }


    
}
