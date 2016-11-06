//
//  TweetsViewController.swift
//  Twitter-iOS
//
//  Created by Keith Smyth on 29/10/2016.
//  Copyright © 2016 Keith Smyth. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ComposeViewControllerDelegate {
    
    @IBOutlet weak var tweetsTableView: UITableView!
    
    var adapter: TableViewAdapter!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweetsTableView.dataSource = self
        tweetsTableView.delegate = self
        tweetsTableView.estimatedRowHeight = 120
        tweetsTableView.rowHeight = UITableViewAutomaticDimension
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(fetchTweets(refreshControl:)), for: UIControlEvents.valueChanged)
        tweetsTableView.insertSubview(refreshControl, at: 0)
        
        navigationItem.title = adapter.title
        adapter.tableView = tweetsTableView
        fetchTweets(refreshControl: nil)
    }
    
    @IBAction func onLogout(_ sender: AnyObject) {
        TwitterClient.sharedInstance.logout()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return adapter.tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tweetsTableView.dequeueReusableCell(withIdentifier: "TweetTableViewCell", for: indexPath) as! TweetTableViewCell
        let tweet = adapter.tweets[indexPath.row]
        
        cell.tweet = tweet
        
        cell.retweetedLabel.isHidden = true
        
        if let profileImageUrl = tweet.user?.profileImageUrl {
            cell.profileImage.setImageWith(profileImageUrl)
            cell.profileImage.layer.cornerRadius = 4.0
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func fetchTweets(refreshControl: UIRefreshControl?) {
        adapter.fetchTweets(refreshControl: refreshControl)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navController = segue.destination as! UINavigationController
        if let composeViewController = navController.topViewController as? ComposeViewController {
            composeViewController.delegate = self
        } else if let detailsViewController = navController.topViewController as? DetailsViewController {
            let cell = sender as? TweetTableViewCell
            detailsViewController.tweet = cell?.tweet
        }
    }
    
    func composeViewController(tweet text: String) {
        let twitterClient = TwitterClient.sharedInstance
        twitterClient.postTweet(text: text,
                                success: { (tweet: Tweet) in
                                    //self.adapter.tweets.insert(tweet, at: 0) // TODO: add tweet insert trick back to protocol
                                    self.tweetsTableView.reloadData()
        }) { (error: Error?) in
            print("Error sending tweet \(error?.localizedDescription)")
        }
    }
}
