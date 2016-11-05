//
//  MainViewController.swift
//  Twitter-iOS
//
//  Created by Keith Smyth on 4/11/2016.
//  Copyright © 2016 Keith Smyth. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var leftMarginConstraint: NSLayoutConstraint!
    
    var menuViewController: MenuViewController!
    
    var beganLeftMargin: CGFloat!
    
    var contentViewController: UIViewController! {
        set {
            view.layoutIfNeeded()
            newValue.willMove(toParentViewController: self)
            contentView.addSubview(newValue.view)
            newValue.didMove(toParentViewController: self)
            toggleDrawer(toOpen: false)
        }
        get {
            return nil
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        menuViewController = storyboard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        menuViewController.mainViewController = self
        
        menuViewController.willMove(toParentViewController: self)
        menuView.addSubview(menuViewController.view)
        menuViewController.didMove(toParentViewController: self)
        view.layoutIfNeeded()
    }
    
    @IBAction func onContentViewPanGesture(_ sender: UIPanGestureRecognizer) {
        switch (sender.state) {
        case .began:
            beganLeftMargin = leftMarginConstraint.constant
        case .changed:
            let translation = sender.translation(in: view)
            leftMarginConstraint.constant = beganLeftMargin + translation.x
        case .ended:
            let velocity = sender.velocity(in: self.view)
            toggleDrawer(toOpen: velocity.x > 0)
        default:
            break
        }
    }
    
    func toggleDrawer(toOpen: Bool) {
        UIView.animate(withDuration: 0.3) { 
            self.leftMarginConstraint.constant = toOpen
                ? self.view.frame.size.width - 50
                : 0
            self.view.layoutIfNeeded()
        }
    }
}
