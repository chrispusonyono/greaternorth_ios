//
//  PickupTableViewCell.swift
//  XcodeLoginExample
//
//  Created by Chrispus Onyono on 30/08/2017.
//  Copyright © 2017 Belal Khan. All rights reserved.
//

import UIKit

class PickupTableViewCell: UITableViewCell {

    @IBOutlet weak var bak0: CardView!
    @IBOutlet weak var bak1: UIView!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var destination: UILabel!
    @IBOutlet weak var cityFrom: UILabel!
    @IBOutlet weak var cityTo: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var use0: UILabel!
    @IBOutlet weak var callButton: UIImageView!
    @IBOutlet weak var use1: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        bak1.layer.cornerRadius = self.bak1.frame.size.width / 2;
        bak1.layer.masksToBounds = true;
        //name.textColor = UIColor(red: 0.29, green: 0.36, blue: 0.40, alpha: 1)
        location.textColor = UIColor(red: 0.29, green: 0.36, blue: 0.40, alpha: 1)
        destination.textColor = UIColor(red: 0.29, green: 0.36, blue: 0.40, alpha: 1)
        cityFrom.textColor = UIColor(red: 0.29, green: 0.36, blue: 0.40, alpha: 1)
        cityTo.textColor = UIColor(red: 0.29, green: 0.36, blue: 0.40, alpha: 1)
        use0.textColor = UIColor(red: 0.29, green: 0.36, blue: 0.40, alpha: 1)
        use1.textColor = UIColor(red: 0.29, green: 0.36, blue: 0.40, alpha: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
