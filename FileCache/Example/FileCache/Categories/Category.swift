//
//  Category.swift
//  FileCacheExample
//
//  Created by Weerasooriya, Tulakshana on 5/14/17.
//  Copyright © 2017 Tulakshana. All rights reserved.
//

import Foundation

class Category {
    
    var title: NSString?
    var photoCount: NSNumber?
    var photosURL: NSString?
    
    init(dictionary: [String:AnyObject]) {
        
        if let title: NSString = dictionary["title"] as? NSString {
            self.title = title
        }
        if let count: NSNumber = dictionary["photo_count"] as? NSNumber {
            self.photoCount = count
        }
        if let linksDic: [String:AnyObject] = dictionary["links"] as? [String:AnyObject] {
            if let url: NSString = linksDic["photos"] as? NSString {
                self.photosURL = url
            }
        }
    }
}
