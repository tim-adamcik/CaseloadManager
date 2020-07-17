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
    
    var currentAgeGroup: String! 
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = currentAgeGroup
        
        let barViewControllers = self.tabBarController?.viewControllers
        let svc = barViewControllers![1] as! GroupsViewController
        svc.currentAgeGroup = currentAgeGroup
    }
    
    
}
