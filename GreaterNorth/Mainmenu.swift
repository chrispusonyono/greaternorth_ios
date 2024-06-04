//
//  Mainmenu.swift
//  XcodeLoginExample
//
//  Created by Chrispus Onyono on 26/08/2017.
//  Copyright © 2017 Belal Khan. All rights reserved.
//

import UIKit
import Alamofire
class Mainmenu: UITabBarController {
    
    let defaultValues = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        
        //hiding back button
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
        tabBarController?.selectedIndex=0
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
}
