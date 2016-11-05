//
//  ViewControllerAdapter.swift
//  Twitter-iOS
//
//  Created by Keith Smyth on 6/11/2016.
//  Copyright © 2016 Keith Smyth. All rights reserved.
//

import Foundation
import UIKit

@objc protocol TableViewAdapter: class {
    
    var title: String { get }
    
    var tableView: UITableView! { get set }
    
    var tweets: [Tweet] { get }
    
    func fetchTweets(refreshControl: UIRefreshControl?)
}
