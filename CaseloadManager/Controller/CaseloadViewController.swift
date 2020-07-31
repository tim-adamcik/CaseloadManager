//
//  CaseloadViewController.swift
//  CaseloadManager
//
//  Created by Timothy Adamcik on 7/17/20.
//  Copyright © 2020 Timothy Adamcik. All rights reserved.
//

import Foundation
import UIKit

class CaseloadViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var currentAgeGroup: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.navigationItem.title = currentAgeGroup
        var ageGroup = AgeGroup(name: currentAgeGroup, students: [])
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Student", style: .plain, target: self, action: #selector(addStudent(_:)))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(goBackToAgeGroupSelection(_:)))
        
        let barViewControllers = self.tabBarController?.viewControllers
        let svc = barViewControllers![1] as! UINavigationController
        let secondVC = svc.viewControllers[0] as! GroupsViewController
        secondVC.currentAgeGroup = currentAgeGroup
        
    }
    
    @objc func addStudent(_ sender: Any) {
        let nc = storyboard?.instantiateViewController(identifier: "NewStudentNC") as! UINavigationController
        nc.modalPresentationStyle = .fullScreen
        present(nc, animated: true)
    }
    
    @objc func goBackToAgeGroupSelection(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
 
}

extension CaseloadViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CaseloadTableViewCell") as! CaseloadTableViewCell
        cell.title.text = currentAgeGroup
        cell.subtitle.text = "Student Name"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    
}
