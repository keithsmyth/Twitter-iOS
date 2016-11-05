//
//  TweetsAdapter.swift
//  Twitter-iOS
//
//  Created by Keith Smyth on 6/11/2016.
//  Copyright © 2016 Keith Smyth. All rights reserved.
//

import Foundation
import UIKit

class TweetsAdapter: TableViewAdapter {
    
    var title = "Home"
    
    var tableView: UITableView!
    
    var tweets = [Tweet]()
    
    func fetchTweets(refreshControl: UIRefreshControl?) {
        Tweet.getHomeTimeline(aSuccess: { (tweets: [Tweet]) in
            self.tweets = tweets
            self.tableView.reloadData()
            refreshControl?.endRefreshing()
        }) { (error: Error?) in
            print("Error fetching tweets \(error?.localizedDescription)")
        }
    }
}
