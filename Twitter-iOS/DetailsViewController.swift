//
//  DetailsViewController.swift
//  Twitter-iOS
//
//  Created by Keith Smyth on 30/10/2016.
//  Copyright © 2016 Keith Smyth. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var createdLabel: UILabel!
    @IBOutlet weak var retweetsLabel: UILabel!
    @IBOutlet weak var favoritesLabel: UILabel!
    
    var tweet: Tweet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let profileImageUrl = tweet?.user?.profileImageUrl {
            imageView.setImageWith(profileImageUrl)
        }
        
        nameLabel.text = tweet?.user?.name
        if let screenName = tweet?.user?.screenName {
            screenNameLabel.text = "@\(screenName)"
        } else {
            screenNameLabel.text = ""
        }
        tweetTextLabel.text = tweet?.text ?? ""
        createdLabel.text = tweet?.formattedTime
        retweetsLabel.text = tweet != nil ? "\(tweet!.retweetCount)" : nil
        favoritesLabel.text = tweet != nil ? "\(tweet!.favoriteCount)" : nil
    }
    
    @IBAction func onHome(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
}
