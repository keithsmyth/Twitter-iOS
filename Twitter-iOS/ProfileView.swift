//
//  ProfileView.swift
//  Twitter-iOS
//
//  Created by Keith Smyth on 6/11/2016.
//  Copyright © 2016 Keith Smyth. All rights reserved.
//

import UIKit

class ProfileView: UIView {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var tweetsLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubViews()
    }
    
    func initSubViews() {
        let nib = UINib(nibName: "ProfileView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
    }
    
    func bind(user: User) {
        if let bannerImageUrl = user.bannerImageUrl {
            bannerImage.setImageWith(bannerImageUrl)
            bannerImage.clipsToBounds = true
        }
        if let profileImageUrl = user.profileImageUrl {
            profileImage.setImageWith(profileImageUrl)
            profileImage.layer.cornerRadius = 4.0
            profileImage.clipsToBounds = true
        }
        nameLabel.text = user.name
        screenNameLabel.text = "@\(user.screenName!)"
        tweetsLabel.text = "\(user.tweetCount) tweets"
        followingLabel.text = "\(user.followingCount) following"
        followersLabel.text = "\(user.followersCount) followers"
    }
}
