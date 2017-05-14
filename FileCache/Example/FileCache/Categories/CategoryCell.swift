//
//  CategoryCell.swift
//  FileCacheExample
//
//  Created by Weerasooriya, Tulakshana on 5/14/17.
//  Copyright © 2017 Tulakshana. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {
    
    func setCategoryDetails(cat: Category) {
        if let name: String = cat.title as? String {
            self.textLabel?.text = name
        }
        if let count: NSNumber = cat.photoCount {
            if count == 1 {
                self.detailTextLabel?.text = "1 photo"
            }else {
                self.detailTextLabel?.text = String.init(format: "%@ photos", count)
            }
        }
    }
}
