//
//  PopUpViewController.swift
//  XcodeLoginExample
//
//  Created by Chrispus Onyono on 02/09/2017.
//  Copyright © 2017 Belal Khan. All rights reserved.
//

import UIKit
import Alamofire
class PopUpViewController: UIViewController {
    var pickup:Pickup!
    var status:String!
    let APP_BASE_URL = Constant.URLS.PROJECT
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        let complete = UITapGestureRecognizer(target: self, action: #selector(PopUpViewController.complete))
        completeView.addGestureRecognizer(complete)
        completeView.isUserInteractionEnabled = true
        
        
        let arrivecancel = UITapGestureRecognizer(target: self, action: #selector(PopUpViewController.arrivedCanceled))
        arriveCancelView.addGestureRecognizer(arrivecancel)
        arriveCancelView.isUserInteractionEnabled = true
        
        
        
        let noshow = UITapGestureRecognizer(target: self, action: #selector(PopUpViewController.noShow))
        noShowView.addGestureRecognizer(noshow)
        noShowView.isUserInteractionEnabled = true
        
        
        
        
        let cancel = UITapGestureRecognizer(target: self, action: #selector(PopUpViewController.cancel))
        cancelView.addGestureRecognizer(cancel)
        cancelView.isUserInteractionEnabled = true
        
        
        
        
        let closepop = UITapGestureRecognizer(target: self, action: #selector(PopUpViewController.closePopUp))
        closePopUpView.addGestureRecognizer(closepop)
        closePopUpView.isUserInteractionEnabled = true
        
        
        
        
        let outSide = UITapGestureRecognizer(target: self, action: #selector(PopUpViewController.closePopUp))
        outSideView.addGestureRecognizer(outSide)
        outSideView.isUserInteractionEnabled = true
        
        
        
        
        
        
    }
    @IBOutlet weak var closePopUpView: UIImageView!
    @IBOutlet weak var completeView: UIView!
    @IBOutlet weak var cancelView: UIView!
    @IBOutlet weak var arriveCancelView: UIView!
    @IBOutlet weak var noShowView: UIView!
    @IBOutlet var outSideView: UIView!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func noShow() {
        pickup.status="NS"
        completeOption(pickup: pickup)
    }
    
    @objc func arrivedCanceled() {
        pickup.status="AR"
        completeOption(pickup: pickup)
    }
    @objc func complete() {
        pickup.status="C"
        completeOption(pickup: pickup)
    }
    
    @objc func cancel() {
        pickup.status="R"
        completeOption(pickup: pickup)
    }
    
    
    @objc func closePopUp() {
        self.view.removeFromSuperview()
    }
 
    
    
    func completeOption(pickup: Pickup){
        closePopUp()
        let parameters: Parameters=[
            "action":"update",
            "id":pickup.id,
            "status":pickup.status
        ]
        Alamofire.request(APP_BASE_URL, method: .post, parameters: parameters).responseJSON
            {
                response in
                print(response)
                pickupInstance.pickups[pickupInstance.selectedId]=pickup
                let indexPath = IndexPath(item: pickupInstance.selectedId, section: 0 )
                
               pickupInstance.pickupTableView.reloadRows(at: [indexPath], with: .top)
        }
        
        
    }

}
