//
//  UsersVC.swift
//  FileCacheExample
//
//  Created by Weerasooriya, Tulakshana on 5/11/17.
//  Copyright © 2017 Tulakshana. All rights reserved.
//

import UIKit
import SVProgressHUD

class UsersVC: UIViewController {
    let dataSource: UsersDS = UsersDS()
    let categoriesSegue: String = "categoriesSegue"
    private let refreshControl: UIRefreshControl = UIRefreshControl.init()
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource.delegate = self
        dataSource.loadUsers()
        self.setupPullToRefresh()
        self.title = "Users"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        SVProgressHUD.dismiss()
        
        super.viewWillDisappear(animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == categoriesSegue {
            if let vc: CategoriesVC = segue.destination as? CategoriesVC {
                if let row: Int = tableView.indexPathForSelectedRow?.row {
                    if let user: User = dataSource.usersArray.object(at: row) as? User {
                        vc.user = user
                    }
                }
            }
        }
    }
    
    //MARK:-
    
    func setupPullToRefresh() {
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: UIControlEvents.valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func handleRefresh() {
        dataSource.resetCache()
        dataSource.loadUsers()
        refreshControl.endRefreshing()
    }
}

extension UsersVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell: UserCell = tableView.dequeueReusableCell(withIdentifier: "userCellIdentifier") as? UserCell {
            if let user: User = dataSource.usersArray.object(at: indexPath.row) as? User {
                cell.setUserDetails(user: user, indexPath: indexPath)
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.usersArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: categoriesSegue, sender: self)
    }
}

extension UsersVC: UsersDSDelegate {
    
    func usersDSDidChange() {
        tableView.reloadData()
    }
}
