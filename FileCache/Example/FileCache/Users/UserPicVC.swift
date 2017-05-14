//
//  UserPicVC.swift
//  FileCacheExample
//
//  Created by Weerasooriya, Tulakshana on 5/14/17.
//  Copyright © 2017 Tulakshana. All rights reserved.
//

import UIKit
import SVProgressHUD

class UserPicVC: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    var imageURL: NSString?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveFileCacheDidDownloadFile(notification:)), name: Notification.Name.init(rawValue: notificationFileCacheDidDownloadFile), object: nil)
        self.loadImage()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        SVProgressHUD.dismiss()
        
        super.viewWillDisappear(animated)
    }
    
    //MARK:-
    
    func loadImage() {
        if let url: NSString = imageURL {
            SVProgressHUD.show()
            FileCache.sharedInstance.fetchFileForURL(urlString: url)
        }
    }
    
    @objc func didReceiveFileCacheDidDownloadFile(notification: Notification) {
        if let cachedFile: FCFile = notification.object as? FCFile {
            if cachedFile.urlString == imageURL {
                if let data: NSData = cachedFile.fileData {
                    imageView.image = UIImage.init(data: data as Data)
                }
                SVProgressHUD.dismiss()
            }
        }
    }
}
