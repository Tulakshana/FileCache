//
//  UserCell.swift
//  FileCacheExample
//
//  Created by Weerasooriya, Tulakshana on 5/14/17.
//  Copyright © 2017 Tulakshana. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    
    private var user: User!
    private var indexPath: IndexPath!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveFileCacheDidDownloadFile(notification:)), name: Notification.Name.init(rawValue: notificationFileCacheDidDownloadFile), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func didReceiveFileCacheDidDownloadFile(notification: Notification) {
        if let cachedFile: FCFile = notification.object as? FCFile {
            if cachedFile.urlString == user.thumbURL {
                if let data: NSData = cachedFile.fileData {
                    self.imageView?.image = UIImage.init(data: data as Data)
                }
            }
        }
    }

    func setUserDetails(user: User, indexPath: IndexPath) {
        self.user = user
        self.indexPath = indexPath
        
        if let name: String = user.name as? String {
            self.textLabel?.text = name
        }
        if let uname: String = user.username as? String {
            self.detailTextLabel?.text = uname
        }
        
        self.imageView?.image = UIImage.init(contentsOfFile: Bundle.main.path(forResource: "placeholder", ofType: "png")!)
        if let url: NSString = user.thumbURL {
            FileCache.sharedInstance.fetchFileForURL(urlString: url)
        }
    }
}
