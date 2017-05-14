//
//  UsersDS.swift
//  FileCacheExample
//
//  Created by Weerasooriya, Tulakshana on 5/11/17.
//  Copyright © 2017 Tulakshana. All rights reserved.
//

import Foundation
import SVProgressHUD

protocol UsersDSDelegate {
    func usersDSDidChange()
}

class UsersDS {
    var usersArray: NSArray = NSArray()
    var delegate: UsersDSDelegate?
    
    private let usersAPI: NSString = "https://pastebin.com/raw/wgkJgazE"
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveFileCacheDidDownloadFile(notification:)), name: Notification.Name.init(rawValue: notificationFileCacheDidDownloadFile), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK:-
    
    func loadUsers() {
        SVProgressHUD.show()
        FileCache.sharedInstance.fetchFileForURL(urlString: usersAPI)
    }
    
    func resetCache() {
        FileCache.sharedInstance.clearCacheForURL(urlString: usersAPI)
    }
    
    @objc func didReceiveFileCacheDidDownloadFile(notification: Notification) {
        if let cachedFile: FCFile = notification.object as? FCFile {
            if cachedFile.urlString == usersAPI {
                if let data: NSData = cachedFile.fileData {
                    if let JSONArray: [[String:AnyObject]] = data.JSONobject() as? [[String:AnyObject]] {
                        let newUsersArray: NSMutableArray = NSMutableArray()
                        for object: [String:AnyObject] in JSONArray {
                            let newUser: User = User.init(dictionary: object)
                            newUsersArray.add(newUser)
                        }
                        usersArray = newUsersArray
                        delegate?.usersDSDidChange()
                    }
                }
                SVProgressHUD.dismiss()
            }
        }
    }}
