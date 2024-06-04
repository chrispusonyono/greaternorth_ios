//
//  PickupTableViewController.swift
//  XcodeLoginExample
//
//  Created by Chrispus Onyono on 30/08/2017.
//  Copyright © 2017 Belal Khan. All rights reserved.
//

import UIKit
import Alamofire
class PickupTableViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    var selectedId:Int!
    let APP_BASE_URL = Constant.URLS.PROJECT
    let defaultValues = UserDefaults.standard
    var viewForTodayDefault=true
    var tommorowPickups = [Pickup]()
    var todayPickups = [Pickup]()
    var pickups = [Pickup]()
    var refreshControl: UIRefreshControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickupTableView.delegate = self
        self.pickupTableView.separatorStyle = .none
        //  self.view.backgroundColor = UIColor(red: 0.83, green: 0.83, blue: 0.83, alpha: 1);
        fetchData()
        pickupInstance=self
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        pickupTableView.addSubview(refreshControl)
    }
    @objc func refresh(sender:AnyObject) {
        fetchData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
         return 1
     }
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
         return pickups.count
      }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "PickupTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PickupTableViewCell  else {
            print("The dequeued cell is not an instance of FuelTableViewCell.")
            fatalError("The dequeued cell is not an instance of FuelTableViewCell.")
        }
        
        let pickup = pickups[indexPath.row]
        var statusText=""
        var color = UIColor(red: 0.47, green: 0.32, blue: 0.07, alpha: 1);
        switch pickup.status {
        case "C":
            statusText="Completed"
            color=UIColor(red:0.23, green:0.61, blue:0.18, alpha:0.9);
            break
        case "P":
            statusText="Pending"
            color=UIColor(red:1.00, green:0.83, blue:0.30, alpha:0.9);
            break
        case "R":
            statusText="Canceled"
            color=UIColor(red: 1.00, green: 0.00, blue: 0.00, alpha:0.9);
            break
        case "AR":
            statusText="Arrived Canceled"
            color=UIColor(red:0.67, green:0.68, blue:0.70, alpha:0.9);
            break
        case "NS":
            statusText="No Show"
            color=UIColor(red:0.47, green:0.33, blue:0.06, alpha:0.9);
            break
        default:
            break
        }
        
        
        cell.bak0.backgroundColor=color
        cell.bak1.backgroundColor=color
        cell.status.textColor=color
        cell.status.text = statusText
        cell.name.text = pickup.name
        cell.location.text = pickup.location
        cell.destination.text = pickup.destination
        cell.cityFrom.text = pickup.locationCity
        cell.cityTo.text = pickup.destinationCity
        cell.time.text = pickup.time
        cell.selectionStyle = .none
        
        let calling = UITapGestureRecognizer(target: self, action: #selector(PickupTableViewController.startCalling(gesture:)))
        
        
        cell.callButton.addGestureRecognizer(calling)
        cell.callButton.isUserInteractionEnabled = true
        cell.callButton.tag = indexPath.row
        
        // cell.backgroundColor = UIColor(red: 0.83, green: 0.83, blue: 0.83, alpha: 1)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)!")
        selectedId=indexPath.row
        
            let pickup = pickups[indexPath.row]
            if(pickup.status == "P" && pickup.showIn == "N"){
                
                let detail = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "popUp") as! PopUpViewController
                detail.pickup = pickup
                self.addChildViewController(detail)
                detail.view.frame = self.view.frame
                self.view.addSubview(detail.view)
                detail.didMove(toParentViewController: self)
                
                
                
        }
    }
    @IBAction func viewFor(_ sender: UISegmentedControl) {
       // sender.selectedSegmentIndex
        switch sender.selectedSegmentIndex {
        case 0:
            self.viewForTodayDefault=true
            self.pickups=self.todayPickups
            self.pickupTableView.reloadData()
            break
        case 1:
            self.viewForTodayDefault=false
            self.pickups=self.tommorowPickups
            self.pickupTableView.reloadData()
            break
        default:
            break
            
            
        }
    }
    
    @objc func startCalling(gesture: UIGestureRecognizer){
        let imageView = gesture.view as? UIImageView
        let position = imageView?.tag ?? 0
        let pickup = pickups[position]
        print("calling :\(pickup.mobile)")
        
        if let url = URL(string: "tel://\(pickup.mobile)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
        
        
       // print("calling clicked String(describing: \(imageView?.t)ag)")
    }
    
    @IBOutlet weak var pickupTableView: UITableView!
    func fetchData() {

        let parameters: Parameters=[
            "action":"fetchall",
            "userId":defaultValues.string(forKey: "id")!
        ]
        
        Alamofire.request(APP_BASE_URL, method: .post, parameters: parameters).responseJSON
            {
                response in
                //print(response)
                if (self.refreshControl.isRefreshing){
                    self.refreshControl.endRefreshing()
                    self.tommorowPickups = [Pickup]()
                    self.todayPickups = [Pickup]()
                    self.pickups = [Pickup]()
                    Constant.DATA.PICKUP = [Pickup]()
                }
                if let result = response.result.value {
                    
                    let jsonData = result as! NSDictionary
                    let pickupsData = jsonData.value(forKey: "pickups") as! NSArray
                    
                    for pickupInfo in pickupsData{
                        let pickup = pickupInfo as! NSDictionary
                        print(pickup)
                        let id = pickup.value(forKey: "id") as! String
                        let mobile = pickup.value(forKey: "mobile") as! String
                        let name = pickup.value(forKey: "name") as! String
                        let location = pickup.value(forKey: "location") as! String
                        let destination = pickup.value(forKey: "destination") as! String
                        let time = pickup.value(forKey: "pTime") as! String
                        let dtime = pickup.value(forKey: "dTime") as! String
                        let status = pickup.value(forKey: "status") as! String
                        let showIn = pickup.value(forKey: "showIn") as! String
                        let destinationCity = pickup.value(forKey: "destinationCity") as! String
                        let locationCity = pickup.value(forKey: "locationCity") as! String
                        let dNumber = pickup.value(forKey: "dNumber") as! String
                        
                        guard let pickupData = Pickup(
                            id: id,
                            mobile: mobile,
                            name: name,
                            location: location,
                            destination: destination,
                            time: time,
                            dtime: dtime,
                            status: status,
                            showIn: showIn,
                            locationCity: locationCity,
                            destinationCity: destinationCity,
                            destinationNumber: dNumber
                            ) else {
                            print("error on adding Pickup")
                            fatalError("Unable to instantiate Pickup")}
                        
                        if(pickupData.showIn == "N"){
                            self.todayPickups += [pickupData]
                        }else if(pickupData.showIn == "T"){
                            self.tommorowPickups += [pickupData]
                        }
                        Constant.DATA.PICKUP += [pickupData]
                        
                    }
                    
                    
                    
                    
                    
                }
                if(self.viewForTodayDefault) {
                    self.pickups=self.todayPickups
                }else{
                    self.pickups=self.tommorowPickups
                }
                self.pickupTableView.reloadData()
                
        }
        
    }
    
    
    
}
var pickupInstance = PickupTableViewController()
		
