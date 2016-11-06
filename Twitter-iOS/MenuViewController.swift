//
//  MenuViewController.swift
//  Twitter-iOS
//
//  Created by Keith Smyth on 4/11/2016.
//  Copyright © 2016 Keith Smyth. All rights reserved.
//

import UIKit

struct MenuItem {
    
    let title: String
    let viewController: UIViewController
    
    init(_ title: String, storyboard: UIStoryboard, adapter: TableViewAdapter) {
        self.title = title
        let navigationController = storyboard.instantiateViewController(withIdentifier: "TweetsNavigationController") as! UINavigationController
        let tweetsViewController = navigationController.topViewController as! TweetsViewController
        tweetsViewController.adapter = adapter
        viewController = navigationController
    }
}

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var menuTableView: UITableView!
    
    var menuItems = [MenuItem]()
    
    weak var mainViewController: MainViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // profile
        menuItems.append(MenuItem("Profile", storyboard: storyboard, adapter: ProfileAdapter()))
        // home
        let tweetsMenuItem = MenuItem("Home", storyboard: storyboard, adapter: TweetsAdapter())
        menuItems.append(tweetsMenuItem)
        // mentions
        menuItems.append(MenuItem("Mentions", storyboard: storyboard, adapter: MentionsAdapter()))
        
        mainViewController.contentViewController = tweetsMenuItem.viewController
        
        menuTableView.delegate = self
        menuTableView.dataSource = self
        menuTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("cell count \(menuItems.count)")
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = menuTableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
        cell.nameLabel.text = menuItems[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        mainViewController.contentViewController = menuItems[indexPath.row].viewController
    }
}
