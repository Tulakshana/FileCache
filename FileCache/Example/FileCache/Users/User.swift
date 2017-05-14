//
//  User.swift
//  FileCacheExample
//
//  Created by Weerasooriya, Tulakshana on 5/14/17.
//  Copyright © 2017 Tulakshana. All rights reserved.
//

import Foundation

class User {
    var username: NSString?
    var name: NSString?
    var imageURL: NSString?
    var thumbURL: NSString?
    var sampleWorkURL: NSString?
    var categoriesArray: NSArray = NSArray()
    var unsplashLink: NSString?
    
    init(dictionary: [String:AnyObject]) {
        
        if let user: [String:AnyObject] = dictionary["user"] as? [String : AnyObject] {
            if let uname: NSString = user["username"] as? NSString {
                self.username = uname
            }
            if let name: NSString = user["name"] as? NSString {
                self.name = name
            }
            if let imageDic: [String:AnyObject] = user["profile_image"] as? [String:AnyObject] {
                if let url: NSString = imageDic["large"] as? NSString {
                    self.imageURL = url
                }
                if let url: NSString = imageDic["small"] as? NSString {
                    self.thumbURL = url
                }
            }
        }

        if let cArray: [[String:AnyObject]] = dictionary["categories"] as? [[String:AnyObject]] {
            let categories: NSMutableArray = NSMutableArray()
            
            for object in cArray {
                let cat: Category = Category.init(dictionary: object)
                categories.add(cat)
            }
            categoriesArray = categories
        }
        
        if let links: [String:AnyObject] = dictionary["links"] as? [String:AnyObject] {
            if let url: NSString = links["html"] as? NSString {
                self.unsplashLink = url
            }
        }
        
        if let urls: [String:AnyObject] = dictionary["urls"] as? [String:AnyObject] {
            if let url: NSString = urls["full"] as? NSString {
                self.sampleWorkURL = url
            }
        }
    }
}
