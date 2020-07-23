//
//  SelectCategoryViewController.swift
//  CaseloadManager
//
//  Created by Timothy Adamcik on 7/23/20.
//  Copyright © 2020 Timothy Adamcik. All rights reserved.
//

import Foundation
import UIKit

class SelectCategoryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let categories = ["Custom", "Articulation", "Phonology", "Receptive Language", "Expressive Language", "Hearing", "AAC", "Pragmatics", "Dysphagia", "Fluency", "Voice", "Cognition"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension SelectCategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel?.text = categories[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "SelectGoalViewController") as! SelectGoalViewController
        vc.modalPresentationStyle = .fullScreen
        vc.selectedCategory = tableView.cellForRow(at: indexPath)?.textLabel?.text
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}
