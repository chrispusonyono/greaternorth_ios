//
//  AddFuelPopUpViewController.swift
//  XcodeLoginExample
//
//  Created by Chrispus Onyono on 06/09/2017.
//  Copyright © 2017 Belal Khan. All rights reserved.
//

import UIKit
import Alamofire
class AddFuelPopUpViewController: UIViewController {
    
    let APP_BASE_URL = Constant.URLS.PROJECT
    @IBOutlet var keyboardGo: UIView!
    @IBOutlet weak var mileage: UITextField!
    @IBOutlet weak var gallons: UITextField!
    @IBOutlet weak var amount: UITextField!
    @IBOutlet weak var closePopUpView: UIImageView!
    @IBOutlet weak var nameFs: UITextField!
    @IBOutlet weak var addFuelBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        let closepop = UITapGestureRecognizer(target: self, action: #selector(AddFuelPopUpViewController.closePopUp))
        closePopUpView.addGestureRecognizer(closepop)
        closePopUpView.isUserInteractionEnabled = true
        addFuelBtn.layer.cornerRadius = 15
        
        let keybordDismis = UITapGestureRecognizer(target: self, action: #selector(AddFuelPopUpViewController.keyboardJustGo))
        keyboardGo.addGestureRecognizer(keybordDismis)
        keyboardGo.isUserInteractionEnabled = true
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func keyboardJustGo()  {
        self.view.endEditing(true)        
    }
    
    @objc func closePopUp() {
        self.view.removeFromSuperview()
    }
    @IBAction func submit(_ sender: UIButton) {
        let defaultValues = UserDefaults.standard
        let names = nameFs.text
        let gallonss = standardForm(digits: gallons.text!) + " Gallons"
        let amounts = "$" + standardForm(digits: amount.text!)
        let mileages = standardForm(digits: mileage.text!) + " Miles"
        
        
        closePopUp()
        let parameters: Parameters=[
            "action":"addFuel",
            "driverId":defaultValues.string(forKey: "id")!,
            "name":names!,
            "cost":amounts,
            "gallons":gallonss,
            "millage":mileages
        ]
        Alamofire.request(APP_BASE_URL, method: .post, parameters: parameters).responseJSON
            {
                response in
                print(response)
                if let result = response.result.value {
                    let jsonData = result as! NSDictionary
                    if((jsonData.value(forKey: "status") as! Bool)){
                        guard let fuelData = Fuel(name: names!, gallons: gallonss, miles: mileages, cost: amounts) else {
                            print("error on adding fuel")
                            fatalError("Unable to instantiate fuel")}                   
                        
                        fuelInstance.fuels += [fuelData]
                        fuelInstance.fuelStopsTableView.reloadData()
                    }
                }
        }
        
        
    }
    func standardForm(digits: String) -> String {
       // var result = digits
      //  if digits.characters.count <= 3{
      //      return digits;
      //  }
    //    for i in 0 ..< digits.characters.count {
     //       let commaPos = digits.characters.count - 3 - (3 * i);
      //      let index1 = result.index(result.startIndex, offsetBy: commaPos)
      //      let index2 = result.index(result.startIndex, offsetBy: commaPos)
      //      result = result.substring(to: index1) + "," + result.substring(from: index2)
     //   }
     //   return result
        let largeNumber = Int(digits)
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        return numberFormatter.string(from: NSNumber(value:largeNumber!))!
    }
}
