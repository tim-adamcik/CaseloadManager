//
//  CaseloadViewController.swift
//  CaseloadManager
//
//  Created by Timothy Adamcik on 7/17/20.
//  Copyright © 2020 Timothy Adamcik. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CaseloadViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var currentAgeGroup: String!
    var ageGroup: AgeGroup?
    var studentArray: [Student]? = []
    
    lazy var studentFetchedResultsController: NSFetchedResultsController<Student> = {
        let fetchRequest: NSFetchRequest<Student> = Student.fetchRequest()
        let predicate = NSPredicate(format: "%K == %@", "ageGroup", currentAgeGroup)
        fetchRequest.predicate = predicate
        let lastNameSort = NSSortDescriptor(key: #keyPath(Student.lastName), ascending: true)
        let firstNameSort = NSSortDescriptor(key: #keyPath(Student.firstName), ascending: true)
        let sortDescriptors = [lastNameSort, firstNameSort]
        fetchRequest.sortDescriptors = sortDescriptors
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.shared.managedContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.navigationItem.title = currentAgeGroup
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Student", style: .plain, target: self, action: #selector(addStudent(_:)))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(goBackToAgeGroupSelection(_:)))
        
        let barViewControllers = self.tabBarController?.viewControllers
        let svc = barViewControllers![1] as! UINavigationController
        let secondVC = svc.viewControllers[0] as! GroupsViewController
        secondVC.currentAgeGroup = currentAgeGroup
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    @objc func addStudent(_ sender: Any) {
        let nc = storyboard?.instantiateViewController(identifier: "NewStudentNC") as! UINavigationController
        nc.modalPresentationStyle = .fullScreen
        let vc = nc.viewControllers[0] as! AddNewStudentViewController
        vc.currentAgeGroup = ageGroup
        present(nc, animated: true)
    }
    
    @objc func goBackToAgeGroupSelection(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
 
}

extension CaseloadViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentFetchedResultsController.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CaseloadTableViewCell") as! CaseloadTableViewCell
        
        if let studentCount = studentFetchedResultsController.sections?.count {
            if studentCount >= 0 {
                       let student = studentFetchedResultsController.object(at: indexPath)
                       cell.title.text = student.lastName
                       cell.subtitle.text = student.firstName
                   }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    
}
