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
        let nc1 = vc.viewControllers?[0] as! UINavigationController
        let nc2 = vc.viewControllers?[1] as! UINavigationController
        let vc1 = nc1.viewControllers[0] as! CaseloadViewController
        let vc2 = nc2.viewControllers[0] as! GroupsViewController
        vc.modalPresentationStyle = .fullScreen
        vc1.currentAgeGroup = ageString
        vc2.currentAgeGroup = ageString
        
        present(vc, animated: true)
//        navigationController?.pushViewController(vc, animated: true)

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
