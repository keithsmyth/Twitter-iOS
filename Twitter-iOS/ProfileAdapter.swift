//
//  ProfileAdapter.swift
//  Twitter-iOS
//
//  Created by Keith Smyth on 6/11/2016.
//  Copyright © 2016 Keith Smyth. All rights reserved.
//

import Foundation
import UIKit

class ProfileAdapter: NSObject, TableViewAdapter {
    
    var title = "Profile"
    
    var tableView: UITableView!
    
    var tweets = [Tweet]()
    
    var user: User?
    
    private var profileView: ProfileView?
    
    init(forUser user: User?) {
        self.user = user
    }
    
    func fetchTweets(refreshControl: UIRefreshControl?) {
        if let user = user {
            fetchTweets(forUser: user.screenName!, refreshControl: refreshControl)
            initProfileView(forUser: user)
        } else {
            fetchCurrentUser(refreshControl: refreshControl)
        }
    }
    
    func fetchCurrentUser(refreshControl: UIRefreshControl?) {
        User.getCurrentUser(success: { (user: User) in
            self.fetchTweets(forUser: user.screenName!, refreshControl: refreshControl)
            self.initProfileView(forUser: user)
        }) { (error: Error?) in
            print("Error fetching user \(error?.localizedDescription)")
        }
    }
    
    func fetchTweets(forUser screenName: String, refreshControl: UIRefreshControl?) {
        Tweet.getUserTimeline(screenName: screenName, aSuccess: { (tweets: [Tweet]) in
            self.tweets = tweets
            self.tableView.reloadData()
            refreshControl?.endRefreshing()
        }) { (error: Error?) in
            print("Error fetching tweets \(error?.localizedDescription)")
        }
    }
    
    func initProfileView(forUser user: User) {
        if profileView != nil {
            return
        }
        profileView = ProfileView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 200))
        profileView!.bind(user: user)
        tableView.tableHeaderView = profileView!
    }
}
