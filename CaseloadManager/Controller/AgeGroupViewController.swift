//
//  AgeGroupViewController.swift
//  CaseloadManager
//
//  Created by Timothy Adamcik on 7/17/20.
//  Copyright © 2020 Timothy Adamcik. All rights reserved.
//

import Foundation
import UIKit
import CoreData

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
        
        var ageGroup: AgeGroup?
        let ageFetch: NSFetchRequest<AgeGroup> = AgeGroup.fetchRequest()
        ageFetch.predicate = NSPredicate(format: "%K == %@", #keyPath(AgeGroup.type), ageString)
        
        do {
            let results = try CoreDataStack.shared.managedContext.fetch(ageFetch)
          if results.count > 0 {
            // AgeName found, Use age name
            ageGroup = results.first

          } else {
            // Name not found, create name
            ageGroup = AgeGroup(context: CoreDataStack.shared.managedContext)
            ageGroup?.type = ageString
            CoreDataStack.shared.saveContext()
          }
        } catch let error as NSError {
          print("Fetch error: \(error) description: \(error.userInfo)")
        }
        
        vc1.currentAgeGroup = ageString
        vc1.ageGroup = ageGroup
        vc2.currentAgeGroup = ageString
        vc2.ageGroup = ageGroup
        
        present(vc, animated: true)
//        navigationController?.pushViewController(vc, animated: true)

    }
    
    @IBAction func schoolAgePressed(_ sender: Any) {
        segueToCaseload(ageString: "SchoolAged")
    }
    @IBAction func elderlyPressed(_ sender: Any) {
        segueToCaseload(ageString: "Elderly")
    }
    @IBAction func earlyChildhoodPressed(_ sender: Any) {
        segueToCaseload(ageString: "EarlyChildhood")
    }
}
