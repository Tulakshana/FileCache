//
//  NSDataJSON.swift
//  FileCacheExample
//
//  Created by Weerasooriya, Tulakshana on 5/14/17.
//  Copyright © 2017 Tulakshana. All rights reserved.
//

import Foundation

extension NSData {
    func JSONobject(options:JSONSerialization.ReadingOptions = .allowFragments) -> AnyObject? {
        return (try! (JSONSerialization.jsonObject(with: self as Data, options: options)) as AnyObject?)
    }
}
