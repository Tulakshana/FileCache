//
//  CategoriesVC.swift
//  FileCacheExample
//
//  Created by Weerasooriya, Tulakshana on 5/14/17.
//  Copyright © 2017 Tulakshana. All rights reserved.
//

import UIKit

class CategoriesVC: UIViewController {
    
    var user: User?
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Categories"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let vc: UserPicVC = segue.destination as? UserPicVC {
            if segue.identifier == "profilePicSegue" {
                if let url: NSString = user?.imageURL {
                    vc.imageURL = url
                    vc.title = "Profile Picture"
                }
            } else if segue.identifier == "sampleWorkSegue" {
                if let url: NSString = user?.sampleWorkURL {
                    vc.imageURL = url
                    vc.title = "Sample Work"
                }
            }
        }

    }
}

extension CategoriesVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell: CategoryCell = tableView.dequeueReusableCell(withIdentifier: "categoryCellIdentifier") as? CategoryCell {
            if let cat: Category = user?.categoriesArray.object(at: indexPath.row) as? Category {
                cell.setCategoryDetails(cat: cat)
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (user?.categoriesArray.count)!
    }
}
