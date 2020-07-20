//
//  AddNewStudentViewController.swift
//  CaseloadManager
//
//  Created by Timothy Adamcik on 7/20/20.
//  Copyright © 2020 Timothy Adamcik. All rights reserved.
//

import Foundation
import UIKit

class AddNewStudentViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var enterGradeTextField: UITextField!
    @IBOutlet weak var enterAgeTextField: UITextField!
    @IBOutlet weak var enterCaseManagerTextField: UITextField!
    @IBOutlet weak var enterEndDateTextField: UITextField!
    @IBOutlet weak var enterDisorderTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        enterGradeTextField.delegate = self
        enterAgeTextField.delegate = self
        enterCaseManagerTextField.delegate = self
        enterEndDateTextField.delegate = self
        enterDisorderTextField.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        firstNameTextField.becomeFirstResponder()
        
    }
    
    
}

extension AddNewStudentViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1
        
        if let nextResponder = textField.superview?.viewWithTag(nextTag) {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}

extension AddNewStudentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GoalTableViewCell") as! GoalTableViewCell
        
        cell.goalLabel.text = "Student will produce /sh/ with 100% accuracy."
        return cell
    }
}
