//
//  DetailViewController.swift
//  XcodeLoginExample
//
//  Created by Chrispus Onyono on 04/10/2017.
//  Copyright © 2017 Belal Khan. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var pickup:Pickup!
    var navigationLocation:String!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var clientNumber: UILabel!
    @IBOutlet weak var destinationNumber: UILabel!
    @IBOutlet weak var pTime: UILabel!
    @IBOutlet weak var dTime: UILabel!
    @IBOutlet weak var from: UILabel!
    @IBOutlet weak var to: UILabel!
    @IBOutlet weak var fromLaction: UIImageView!
    @IBOutlet weak var toLocation: UIImageView!
    @IBOutlet weak var back: UIButton!
    @IBOutlet weak var completestop: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        back.layer.cornerRadius = 5;
        
        completestop.layer.cornerRadius = 5;
        let fromClicking = UITapGestureRecognizer(target: self, action: #selector(DetailViewController.fromClick))
        fromLaction.addGestureRecognizer(fromClicking)
        fromLaction.isUserInteractionEnabled = true
        
        let toClicking = UITapGestureRecognizer(target: self, action: #selector(DetailViewController.toClick))
        toLocation.addGestureRecognizer(toClicking)
        toLocation.isUserInteractionEnabled = true
        
        fullName.text=pickup.name
        clientNumber.text=pickup.mobile
        destinationNumber.text=pickup.destinationNumber
        pTime.text=pickup.time
        dTime.text=pickup.dtime
        from.text=pickup.location
        to.text=pickup.destination
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func completeStop(_ sender: UIButton) {
        
          let popup = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "popUp") as! PopUpViewController
        popup.pickup = pickup
        pickupInstance.addChildViewController(popup)
        popup.view.frame = pickupInstance.view.frame
        pickupInstance.view.addSubview(popup.view)
        popup.didMove(toParentViewController: pickupInstance)
        closePopUp()
    }
    
    func closePopUp() {
        self.view.removeFromSuperview()
    }
    
    @objc func fromClick(){
        navigationLocation=pickup.location
        goLocation()
    }
    
    @objc func toClick(){
        navigationLocation=pickup.destination
        goLocation()
    }
    
    func goLocation(){
        if (UIApplication.shared.canOpenURL(URL(string: "https://maps.apple.com/")!)) {
          UIApplication.shared.open(URL(string: "http://maps.apple.com/?daddr="+navigationLocation)!)
        }else{
        print("Cant use google maps")
        }
    }
}
