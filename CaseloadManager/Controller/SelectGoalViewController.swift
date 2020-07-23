//
//  SelectGoalViewController.swift
//  CaseloadManager
//
//  Created by Timothy Adamcik on 7/23/20.
//  Copyright © 2020 Timothy Adamcik. All rights reserved.
//

import Foundation
import UIKit

class SelectGoalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    let categories = ["Custom", "Articulation/Phonology", "Receptive Language", "Expressive Language", "Hearing", "AAC", "Pragmatics", "Dysphagia", "Fluency", "Voice", "Cognition"]
    
    var selectedCategory: String!
    var currentArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        currentArray = getCurrentArray(category: selectedCategory)
        
    }
    
    func getCurrentArray(category: String) -> [String] {
        switch selectedCategory {
        case "Custom":
            return GoalArrays.customGoals
        case "Articulation":
            return GoalArrays.articulationGoals
        case "Phonology":
            return GoalArrays.phonologyGoals
        case "Receptive Language":
            return GoalArrays.receptiveLanguageGoals
        case "Expressive Language":
            return GoalArrays.expressiveLanguageGoals
        case "Hearing":
            return GoalArrays.hearingGoals
        case "AAC":
            return GoalArrays.aacGoals
        case "Pragmatics":
            return GoalArrays.pragmaticGoals
        case "Dysphagia":
            return GoalArrays.dysphagiaGoals
        case "Fluency":
            return GoalArrays.fluencyGoals
        case "Voice":
            return GoalArrays.voiceGoals
        case "Cognition":
            return GoalArrays.cognitiveGoals
        default:
            return [""]
        }
    }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            currentArray.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = UITableViewCell()
            cell.textLabel?.text = currentArray[indexPath.row]
            
            return cell
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
