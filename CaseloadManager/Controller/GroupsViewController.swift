//
//  GroupsViewController.swift
//  CaseloadManager
//
//  Created by Timothy Adamcik on 7/17/20.
//  Copyright © 2020 Timothy Adamcik. All rights reserved.
//

import Foundation
import UIKit

class GroupsViewController: UIViewController {
    
    var currentAgeGroup: String!
    var ageGroup: AgeGroup?
    
    
    @IBOutlet weak var tableView: UITableView!
    
    let df = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        navigationItem.title = "Groups"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(goBackToAgeGroupSelection(_:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Group", style: .plain, target: self, action: #selector(addNewGroup(_:)))
    }
    
    @objc func addNewGroup(_ sender: Any) {
           
       }
    
    @objc func goBackToAgeGroupSelection(_ sender: Any) {
           dismiss(animated: true, completion: nil)
       }
}

extension GroupsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupsTableViewCell") as! GroupsTableViewCell
        cell.title.text = currentAgeGroup
        df.dateFormat = "yyyy-MM-dd"
        let date = df.string(from: Date())
        cell.detail.text = date
        return cell
    }
    
    
}
