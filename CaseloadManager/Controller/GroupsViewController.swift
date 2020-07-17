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
    @IBOutlet weak var label: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = currentAgeGroup
    }
}
