//
//  Tweet.swift
//  Twitter-iOS
//
//  Created by Keith Smyth on 29/10/2016.
//  Copyright © 2016 Keith Smyth. All rights reserved.
//

import Foundation

class Tweet {
    var user: User?
    var text: String?
    var retweetCount: Int
    var favoriteCount: Int
    var createdAt: Date?
    
    var timeSinceCreated: String? {
        get {
            if createdAt == nil {
                return nil
            }
            let now = Date()
            let seconds = Calendar.current.dateComponents([Calendar.Component.second], from: createdAt!, to: now).second ?? 0
            if seconds < 60 {
                return "\(seconds)s"
            }
            let minutes = Calendar.current.dateComponents([Calendar.Component.minute], from: createdAt!, to: now).minute ?? 0
            if minutes < 60 {
                return "\(minutes)m"
            }
            let hours = Calendar.current.dateComponents([Calendar.Component.hour], from: createdAt!, to: now).hour ?? 0
            if hours < 24 {
                return "\(hours)h"
            }
            let days = Calendar.current.dateComponents([Calendar.Component.day], from: createdAt!, to: now).day ?? 0
            return "\(days)d"
        }
    }
    
    init(dict: NSDictionary) {
        user = User(dict: dict["user"] as! NSDictionary)
        text = dict["text"] as? String
        retweetCount = (dict["retweet_count"] as? Int) ?? 0
        favoriteCount = (dict["favorite_count"] as? Int) ?? 0
        
        let createdAtString = dict["created_at"] as? String
        if let createdAtString = createdAtString {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            createdAt = formatter.date(from: createdAtString)
        }
    }
    
    class func getTweets(aSuccess: @escaping (([Tweet]) -> ()), aFailure: @escaping ((Error?) -> ())) {
        let twitterClient = TwitterClient.sharedInstance
        twitterClient.get("1.1/statuses/home_timeline.json",
                          parameters: nil,
                          progress: nil,
                          success: { (task: URLSessionDataTask, response: Any?) in
                            var tweets = [Tweet]()
                            for dict in response as! [NSDictionary] {
                                tweets.append(Tweet(dict: dict))
                            }
                            aSuccess(tweets)
            },
                          failure: { (task: URLSessionDataTask?, error: Error) in
                            aFailure(error)
        })
    }

}
