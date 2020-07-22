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
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tbl_height: NSLayoutConstraint!
    
    var activeTextField: UITextField? = nil
    let disorders = ["Speech", "Language", "Speech and Language", "Cognitive Impairment", "Dysphagia"]
    let grades = ["Early Childhood", "Pre-K", "K", "1","2","3","4","5","6","7","8","9","10","11","12","Adult"]
    var pickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        enterAgeTextField.delegate = self
        enterCaseManagerTextField.delegate = self
        enterEndDateTextField.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        pickerView.delegate = self
        pickerView.dataSource = self
        firstNameTextField.becomeFirstResponder()
        enterDisorderTextField.inputView = pickerView
        enterGradeTextField.inputView = pickerView
        
        NotificationCenter.default.addObserver(self, selector: #selector(AddNewStudentViewController.keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AddNewStudentViewController.keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    

    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            // if keyboard size is not available for some reason, dont do anything
            return
        }
        
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height , right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        
        // Just Move view up length of keyboard when the textField is hidden
        
//        var shouldMoveViewUp = false
//
//        // if active text field is not nil
//        if let activeTextField = activeTextField {
//
//            let bottomOfTextField = activeTextField.convert(activeTextField.bounds, to: self.view).maxY;
//
//            let topOfKeyboard = self.view.frame.height - keyboardSize.height
//
//            // if the bottom of Textfield is below the top of keyboard, move up
//            if bottomOfTextField > topOfKeyboard {
//                shouldMoveViewUp = true
//            }
//        }
//
//        if (shouldMoveViewUp) {
//            self.view.frame.origin.y = 0 - keyboardSize.height
//        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
      // move back the root view origin to zero
//      self.view.frame.origin.y = 0
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
               
           
           // reset back the content inset to zero after keyboard is gone
           scrollView.contentInset = contentInsets
           scrollView.scrollIndicatorInsets = contentInsets
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.activeTextField = nil
    }
}

extension AddNewStudentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GoalTableViewCell") as! GoalTableViewCell
        
        cell.goalLabel.text = "Student will produce /sh/ with 100% accuracy."
        return cell
    }
}

extension AddNewStudentViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if enterGradeTextField.isFirstResponder {
            return grades.count
        } else if enterDisorderTextField.isFirstResponder {
            return disorders.count
        } else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
         if enterGradeTextField.isFirstResponder {
                   return grades[row]
               } else if enterDisorderTextField.isFirstResponder {
                   return disorders[row]
               }
        return nil
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if enterGradeTextField.isFirstResponder {
            enterGradeTextField.text = grades[row]
            enterAgeTextField.becomeFirstResponder()
        } else if enterDisorderTextField.isFirstResponder {
            enterDisorderTextField.text = disorders[row]
            enterDisorderTextField.resignFirstResponder()
        }
    }
}
