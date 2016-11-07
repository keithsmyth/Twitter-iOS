//
//  TweetTableViewCell.swift
//  Twitter-iOS
//
//  Created by Keith Smyth on 29/10/2016.
//  Copyright © 2016 Keith Smyth. All rights reserved.
//

import UIKit

protocol TweetTableViewCellDelegate {
    func tweetTableViewCell(onUserImageTapGesture user: User)
}

class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var retweetedLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var tweet: Tweet?
    var delegate: TweetTableViewCellDelegate?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(onImageTapGesture(_:)))
        profileImage.addGestureRecognizer(recognizer)
    }

    func onImageTapGesture(_ sender: UITapGestureRecognizer) {
        if let user = tweet?.user {
            delegate?.tweetTableViewCell(onUserImageTapGesture: user)
        }
    }
}
