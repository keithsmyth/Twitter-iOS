//
//  ViewController.swift
//  Twitter-iOS
//
//  Created by Keith Smyth on 29/10/2016.
//  Copyright © 2016 Keith Smyth. All rights reserved.
//

import UIKit
import BDBOAuth1Manager


class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onLogin(_ sender: AnyObject) {
        TwitterClient.sharedInstance.login(success: { 
            self.performSegue(withIdentifier: "LoginToTweetsSegue", sender: nil)
        }) { (error: Error?) in
            print("Login error \(error?.localizedDescription)")
        }
    }
}
