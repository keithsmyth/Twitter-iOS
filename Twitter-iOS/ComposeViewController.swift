//
//  ComposeViewController.swift
//  Twitter-iOS
//
//  Created by Keith Smyth on 30/10/2016.
//  Copyright © 2016 Keith Smyth. All rights reserved.
//

import UIKit

protocol ComposeViewControllerDelegate: class {
    func composeViewController(tweet text: String)
}

class ComposeViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var tweetText: UITextField!
    
    var delegate: ComposeViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        User.getCurrentUser(
            success: { (user: User) in
                self.populateUser(user: user)
            }, failure: { (error: Error?) in
                print("Failed to fetch user \(error?.localizedDescription)")
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tweetText.becomeFirstResponder()
    }

    @IBAction func onCancel(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onTweet(_ sender: AnyObject) {
        if validateAndNotify() {
            delegate?.composeViewController(tweet: tweetText.text!)
            dismiss(animated: true, completion: nil)
        }
    }
    
    func validateAndNotify() -> Bool {
        let charCount = tweetText.text?.characters.count ?? 0
        
        // cannot be 0
        if charCount == 0 {
            showAlert(title: "Invalid Tweet", message: "Please enter some text")
            return false
        }
        
        // less than 140
        if charCount > 140 {
            showAlert(title: "Invalid Tweet", message: "Please enter less than 140 characters (\(charCount))")
            return false
        }
        
        return true
    }
    
    func showAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func populateUser(user: User) {
        if let profileImageUrl = user.profileImageUrl {
            profileImage.setImageWith(profileImageUrl)
        }
        nameLabel.text = user.name
        screenNameLabel.text = user.screenName
    }
}
