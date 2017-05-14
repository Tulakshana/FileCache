//
//  FCFile.swift
//  FileCache
//
//  Created by Weerasooriya, Tulakshana on 5/11/17.
//  Copyright © 2017 Tulakshana. All rights reserved.
//

import Foundation

class FCFile: NSObject {
    var urlString: NSString?
    var lastAccessedDate: Date = Date()
    var fileData: NSData?
    var downloadInProgress: Bool = true
    
    init(url: NSString) {
        self.urlString = url
    }
    
    func fileSize() -> Float {
        if let data: NSData = fileData {
            return (Float)(data.length/1024)/1024
        }
        return 0.0
    }
}
