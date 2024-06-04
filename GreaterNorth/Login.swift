//
//  ViewController.swift
//  XcodeLoginExample
//
//  Created by Belal Khan on 29/05/17.
//  Copyright © 2017 Belal Khan. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    let URL_USER_LOGIN = Constant.URLS.PROJECT
    
    //the defaultvalues to store user data
    let defaultValues = UserDefaults.standard
    
    @IBOutlet weak var loginBtn: UIButton!
    //the connected views
    //don't copy instead connect the views using assistant editor
    @IBOutlet weak var labelMessage: UILabel!
    @IBOutlet weak var textFieldUserName: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    
    //the button action function
    @IBAction func buttonLogin(_ sender: UIButton) {
        if Reachability.isConnectedToNetwork(){
            print("Internet Connection Available!")
            loginUser()
        }else{
            print("Internet Connection not Available!")
        }
        
        
    }
    func loginUser(){
        print("Device Token: " + UserDefaults.standard.string(forKey: "deviceToken")! )
        //getting the username and password
        let parameters: Parameters=[
            "action":"login",
            "deviceToken":defaultValues.string(forKey: "deviceToken") ?? "0",
            "username":textFieldUserName.text!,
            "password":textFieldPassword.text!
        ]
        
        //making a post request
        Alamofire.request(URL_USER_LOGIN, method: .post, parameters: parameters).responseJSON
            {
                response in
                //printing response
                print(response)
                
                //getting the json value from the server
                if let result = response.result.value {
                    let jsonData = result as! NSDictionary
                    
                    //if there is no error
                    if((jsonData.value(forKey: "status") as! Bool)){
                        
                        //getting the user from response
                       // let user = jsonData.value(forKey: "profile") as! NSDictionary
                        
                        //getting user values
                        let userId = jsonData.value(forKey: "id") as! String
                        let userName = jsonData.value(forKey: "name") as! String
                        let userEmail = jsonData.value(forKey: "email") as! String
                        let userExt = jsonData.value(forKey: "icon") as! String
                        let userPicturePath = self.URL_USER_LOGIN + "icons/" + userId + "." + userExt
                        
                        //saving user values to defaults
                        self.defaultValues.set(userId, forKey: "id")
                        self.defaultValues.set(userPicturePath, forKey: "icon")
                        self.defaultValues.set(userName, forKey: "name")
                        self.defaultValues.set(userEmail, forKey: "useremail")
                        
                        //switching the screen
                        
                        
                        
                        
                        //starting tab menus
                        let mainmenu = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Mainmenu") as!UITabBarController
                        mainmenu.selectedIndex=0
                        self.present(mainmenu,animated: true, completion:nil)
                    }else{
                        //error message in case of invalid credential
                        self.labelMessage.text = "Invalid username or password"
                        //self.labelMessage.textColor="#ff0000"
                    }
                }
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //hiding the navigation button
        loginBtn.layer.cornerRadius = 15
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton

        // Do any additional setup after loading the view, typically from a nib.
        
        //if user is already logged in switching to profile screen
        UIApplication.shared.applicationIconBadgeNumber = 0
        if defaultValues.string(forKey: "name") != nil{
            
            //starting tab menus
            let mainmenu = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Mainmenu") as!UITabBarController
            mainmenu.selectedIndex=0
            self.present(mainmenu,animated: true, completion:nil)
            
            //starting next story board
            
           // let profileViewController = self.storyboard?.instantiateViewController(withIdentifier: "Mainmenu") as! Mainmenu
           // self.navigationController?.pushViewController(profileViewController, animated: true)
            
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

