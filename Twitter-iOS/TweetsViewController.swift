//
//  TweetsViewController.swift
//  Twitter-iOS
//
//  Created by Keith Smyth on 29/10/2016.
//  Copyright © 2016 Keith Smyth. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tweetsTableView: UITableView!
    
    var tweets = [Tweet]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweetsTableView.dataSource = self
        tweetsTableView.delegate = self
        tweetsTableView.estimatedRowHeight = 120
        tweetsTableView.rowHeight = UITableViewAutomaticDimension
        
        fetchTweets()
    }
    
    @IBAction func onLogout(_ sender: AnyObject) {
        TwitterClient.sharedInstance.logout()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tweetsTableView.dequeueReusableCell(withIdentifier: "TweetTableViewCell", for: indexPath) as! TweetTableViewCell
        let tweet = tweets[indexPath.row]
        
        cell.retweetedLabel.isHidden = true
        
        if let profileImageUrl = tweet.user?.profileImageUrl {
            cell.profileImage.setImageWith(profileImageUrl)
            cell.profileImage.layer.cornerRadius = 8.0
            cell.profileImage.clipsToBounds = true
            
        } else {
            cell.profileImage.image = nil
        }
        
        cell.nameLabel.text = tweet.user?.name
        
        if let screenName = tweet.user?.screenName {
            cell.screenNameLabel.text = "@\(screenName)"
        } else {
            cell.screenNameLabel.text = nil
        }
        
        cell.timeLabel.text = tweet.timeSinceCreated
        cell.tweetTextLabel.text = tweet.text
        
        cell.retweetButton.setTitle("Retweet (\(tweet.retweetCount))", for: UIControlState.normal)
        cell.favoriteButton.setTitle("Favorite (\(tweet.favoriteCount))", for: UIControlState.normal)
        
        return cell
    }
    
    func fetchTweets() {
        Tweet.getTweets(aSuccess: { (tweets: [Tweet]) in
            self.tweets = tweets
            self.tweetsTableView.reloadData()
        }) { (error: Error?) in
            print("Error fetching tweets \(error?.localizedDescription)")
        }
    }
}
