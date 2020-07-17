//
//  AgeGroupViewController.swift
//  CaseloadManager
//
//  Created by Timothy Adamcik on 7/17/20.
//  Copyright © 2020 Timothy Adamcik. All rights reserved.
//

import Foundation
import UIKit

class AgeGroupViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func segueToCaseload(ageString: String) {
        let vc = storyboard?.instantiateViewController(identifier: "TabBarVC") as! TabBarVC
        let vc1 = vc.viewControllers?[0] as! CaseloadViewController
        let vc2 = vc.viewControllers?[1] as! GroupsViewController
        vc1.currentAgeGroup = ageString
        vc2.currentAgeGroup = ageString
        
        present(vc, animated: true)
    }
    
    @IBAction func schoolAgePressed(_ sender: Any) {
        segueToCaseload(ageString: "schoolAged")
    }
    @IBAction func elderlyPressed(_ sender: Any) {
        segueToCaseload(ageString: "Elderly")
    }
    @IBAction func earlyChildhoodPressed(_ sender: Any) {
        segueToCaseload(ageString: "EarlyChildhood")
    }
}
