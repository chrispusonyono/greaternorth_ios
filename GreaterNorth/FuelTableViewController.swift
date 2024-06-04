//
//  FuelTableViewController.swift
//  XcodeLoginExample
//
//  Created by Chrispus Onyono on 29/08/2017.
//  Copyright © 2017 Belal Khan. All rights reserved.
//

import UIKit
import Alamofire
class FuelTableViewController: UIViewController, UITableViewDataSource  {
    
    @IBOutlet weak var addFuelBtnPopup: UIButton!
    let APP_BASE_URL = Constant.URLS.PROJECT
    let defaultValues = UserDefaults.standard
    var fuels = [Fuel]()
    var refreshControl: UIRefreshControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fuelStopsTableView.separatorStyle = .none
        // self.view.backgroundColor = UIColor(red: 0.83, green: 0.83, blue: 0.83, alpha: 1)
        fetchData()
        fuelInstance=self
        addFuelBtnPopup.layer.cornerRadius = 5
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        fuelStopsTableView.addSubview(refreshControl)
    }
    func refresh(sender:AnyObject) {
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
        return fuels.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "FuelTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? FuelTableViewCell  else {
            print("The dequeued cell is not an instance of FuelTableViewCell.")
            fatalError("The dequeued cell is not an instance of FuelTableViewCell.")
        }
        
        let fuel = fuels[indexPath.row]
        cell.name.text = fuel.name
        cell.gallons.text = fuel.gallons
        cell.miles.text = fuel.miles
        cell.cost.text = fuel.cost
        cell.selectionStyle = .none
        //cell.backgroundColor = UIColor(red: 0.83, green: 0.83, blue: 0.83, alpha: 1)
        return cell
    }
    @IBOutlet weak var fuelStopsTableView: UITableView!
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
                    self.fuels = [Fuel]()
                }
                if let result = response.result.value {
                    
                    let jsonData = result as! NSDictionary
                    let fuelsData = jsonData.value(forKey: "fuel") as! NSArray
                    
                    for fuelInfo in fuelsData{
                        let fuel = fuelInfo as! NSDictionary
                        print(fuel)
                        let name = fuel.value(forKey: "name") as! String
                        let gallons = fuel.value(forKey: "gallons") as! String
                        let miles = fuel.value(forKey: "mileage") as! String
                        let cost = fuel.value(forKey: "cost") as! String
                        
                        guard let fuelData = Fuel(name: name, gallons: gallons, miles: miles, cost: cost) else {
                              print("error on adding fuel")
                                fatalError("Unable to instantiate fuel")}
                        
                         self.fuels += [fuelData]
                    }
                    
                    
                    
                
                    
                }
                
                self.fuelStopsTableView.reloadData()
                
        }
        
    }
    
 
    @IBAction func addFuelStop(_ sender: UIButton) {
        let popup = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "addFuelpopUp") as! AddFuelPopUpViewController
        self.addChildViewController(popup)
        popup.view.frame = self.view.frame
        self.view.addSubview(popup.view)
        popup.didMove(toParentViewController: self)
    }
}
var fuelInstance = FuelTableViewController()
