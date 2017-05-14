//
//  FileCache.swift
//  FileCache
//
//  Created by Weerasooriya, Tulakshana on 5/11/17.
//  Copyright © 2017 Tulakshana. All rights reserved.
//

import Foundation

let notificationFileCacheDidDownloadFile: String = "notificationFileCacheDidDownloadFile"

class FileCache {
    static let sharedInstance:FileCache = FileCache()
    
    var maxCacheSize: Float = 1.00 //size in MB
    
    private var cacheSize: Float = 0.0 //size in MB
    private let cache: NSCache = NSCache<NSString, FCFile>()
    private var cachedURLS: [NSString] = []
    
    func fetchFileForURL(urlString: NSString) {
        if let cachedFile: FCFile = cache.object(forKey: urlString) {
            if !cachedFile.downloadInProgress {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: notificationFileCacheDidDownloadFile), object: cachedFile)
            }
            cachedFile.lastAccessedDate = Date()
        } else {
            let newFile: FCFile = FCFile.init(url: urlString)
            cache.setObject(newFile, forKey: urlString)
            cachedURLS.append(urlString)
            
            if let url: URL = URL.init(string: urlString as String) {
                FCDownloader.downloadFile(url: url, completion: { (fileData: NSData?) in
                    if let cachedFile: FCFile = self.cache.object(forKey: urlString) {
                        if let data: NSData = fileData {
                            cachedFile.fileData = data
                            self.updateCacheSize(size: cachedFile.fileSize())
                        }
                        cachedFile.downloadInProgress = false
                        cachedFile.lastAccessedDate = Date()
                        
                        DispatchQueue.main.sync {
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: notificationFileCacheDidDownloadFile), object: cachedFile)
                        }
                    }
                })
            }
        }
    }
    
    func updateCacheSize(size: Float) {
        cacheSize += size
        
        if cacheSize > maxCacheSize {
            let cachedFilesArray: NSMutableArray = NSMutableArray()
            
            for i in 0...(cachedURLS.count - 1) {
                if let cachedFile: FCFile = self.cache.object(forKey: cachedURLS[i]) {
                    cachedFilesArray.add(cachedFile)
                }
            }
            
            var sortedArray = cachedFilesArray.sortedArray(using: [NSSortDescriptor(key: "lastAccessedDate", ascending: true)])
            
            while cacheSize > maxCacheSize {
                if let oldestFile: FCFile = sortedArray.first as? FCFile {
                    if let url: NSString = oldestFile.urlString {
                        cache.removeObject(forKey: url)
                        cacheSize -= oldestFile.fileSize()
                        sortedArray.removeFirst()
                    }
                }
            }
            
            cachedURLS.removeAll()
            for item: FCFile in (sortedArray as? [FCFile])! {
                if let url: NSString = item.urlString {
                    cachedURLS.append(url)
                }
            }
        }
    }
    
    func clearCacheForURL(urlString: NSString) {
        for i in 0...(cachedURLS.count - 1) {
            if urlString.isEqual(to: cachedURLS[i] as String) {
                cache.removeObject(forKey: urlString)
                cachedURLS.remove(at: i)
                break
            }
        }
    }
}
