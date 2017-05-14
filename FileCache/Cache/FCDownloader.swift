//
//  FCDownloader.swift
//  FileCache
//
//  Created by Weerasooriya, Tulakshana on 5/11/17.
//  Copyright © 2017 Tulakshana. All rights reserved.
//

import Foundation

class FCDownloader {
    class func downloadFile(url: URL, completion: @escaping (_ fileData: NSData?) -> ()) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        let request = URLRequest(url: url)
        
        let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
            if let tempLocalUrl = tempLocalUrl, error == nil {
                completion(NSData(contentsOf: tempLocalUrl))
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
}
