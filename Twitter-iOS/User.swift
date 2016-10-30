//
//  User.swift
//  Twitter-iOS
//
//  Created by Keith Smyth on 29/10/2016.
//  Copyright © 2016 Keith Smyth. All rights reserved.
//

import Foundation

class User {
    var name: String?
    var screenName: String?
    var profileImageUrl: URL?
    var description: String?
    
    init(dict: NSDictionary) {
        name = dict["name"] as? String
        screenName = dict["screen_name"] as? String
        
        let imageUrlString = dict["profile_image_url_https"] as? String
        if let imageUrlString = imageUrlString {
            profileImageUrl = URL(string: imageUrlString)
        }
        
        description = dict["description"] as? String
    }
}
