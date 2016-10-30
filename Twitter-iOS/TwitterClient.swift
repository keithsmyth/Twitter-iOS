//
//  TwitterClient.swift
//  Twitter-iOS
//
//  Created by Keith Smyth on 29/10/2016.
//  Copyright © 2016 Keith Smyth. All rights reserved.
//

import Foundation
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
    static let sharedInstance = TwitterClient(baseURL: URL(string: "https://api.twitter.com"),
                                              consumerKey: "x2udZxXL3OuzbRNFn1Al0hEYR",
                                              consumerSecret: "jDPRFna5DqzKiLnX54HsrPHXF0sBiIJZzMbySW6r32DDYJVjrp")!
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((Error?) -> ())?
    
    func login(success: (() -> ())?, failure: @escaping ((Error?) -> ())) {
        loginSuccess = success
        loginFailure = failure
        
        deauthorize()
        fetchRequestToken(withPath: "oauth/request_token",
                          method: "GET",
                          callbackURL: URL(string: "twitter-iOS://oauth"),
                          scope: nil,
                          success: { (credentials: BDBOAuth1Credential?) in
                            let requestToken = credentials!.token
                            self.requestAuthorization(requestToken: requestToken!)
            },
                          failure: { (error: Error?) in
                            self.loginFailure?(error)
        })
    }
    
    private func requestAuthorization(requestToken: String) {
        var builder = URLComponents(string: "https://api.twitter.com/oauth/authorize")!
        builder.queryItems = [ URLQueryItem(name: "oauth_token", value: requestToken) ]
        UIApplication.shared.open(builder.url!)
    }
    
    func requestAccessToken(query: String) {
        let credential = BDBOAuth1Credential(queryString: query)
        fetchAccessToken(withPath: "oauth/access_token",
                         method: "POST",
                         requestToken: credential,
                         success: { (accessToken: BDBOAuth1Credential?) in
                            self.loginSuccess?()
            },
                         failure: { (error: Error?) in
                            self.loginFailure?(error)
        })
    }
}
