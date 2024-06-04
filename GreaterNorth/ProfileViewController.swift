//
//  ProfileViewController.swift
//  XcodeLoginExample
//
//  Created by Belal Khan on 01/06/17.
//  Copyright © 2017 Belal Khan. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    

    @IBOutlet weak var usernameText: UILabel!
    @IBOutlet weak var useremailText: UILabel!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var logoutBtn: UIButton!
    var token = ""
    
   
    //button
    @IBAction func buttonLogout(_ sender: UIButton) {
        token = UserDefaults.standard.string(forKey: "deviceToken")!
        //removing values from default
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        UserDefaults.standard.synchronize()
        
        //switching to login screen
        let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.navigationController?.pushViewController(loginViewController, animated: true)
        self.dismiss(animated: false, completion: nil)
        UserDefaults.standard.set(token, forKey: "deviceToken")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //hiding back button
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
        
        //getting user data from defaults
        let defaultValues = UserDefaults.standard
        if let name = defaultValues.string(forKey: "name"){
            //setting the name to label 
            usernameText.text = name
            useremailText.text = defaultValues.string(forKey: "useremail")
        }else{
            //send back to login view controller
        }
        
        let picturePath = defaultValues.string(forKey: "icon")!
        
        
        let imageURL: URL = URL(string: picturePath)!
        
        (URLSession(configuration: URLSessionConfiguration.default)).dataTask(with: imageURL, completionHandler: { (imageData, response, error) in
            
            if let data = imageData {
                print("Did download image data")
                
                DispatchQueue.main.async {
                    self.profilePicture.image = UIImage(data: data)
                }
            }
        }).resume()
        profilePicture.layer.cornerRadius = self.profilePicture.frame.size.width / 2;
        profilePicture.layer.borderWidth = 3.0;
        profilePicture.layer.masksToBounds = true;
        logoutBtn.layer.cornerRadius = 5;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
