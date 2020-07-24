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
    let datePicker = UIDatePicker()
    
    fileprivate func createTextFieldAndPickerDelegates() {
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        enterAgeTextField.delegate = self
        enterCaseManagerTextField.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        pickerView.delegate = self
        pickerView.dataSource = self
        firstNameTextField.becomeFirstResponder()
        createDatePicker()
        createPickerView()
        dismissPickerView()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTextFieldAndPickerDelegates()
        
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
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
      // move back the root view origin to zero
//      self.view.frame.origin.y = 0
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
               
           
           // reset back the content inset to zero after keyboard is gone
           scrollView.contentInset = contentInsets
           scrollView.scrollIndicatorInsets = contentInsets
    }
    
    func createDatePicker() {
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: true)
        //assigntoolbar
        enterEndDateTextField.inputAccessoryView = toolbar
        
        //assign datepicker to textfield
        enterEndDateTextField.inputView = datePicker
        
        //datepicker mode
        datePicker.datePickerMode = .date
        
    }
    @objc func donePressed() {
        //create a date formatter
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .short
        
        enterEndDateTextField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
        enterDisorderTextField.becomeFirstResponder()
    }
    

    
    @IBAction func addGoalBtnPressed(_ sender: Any) {
//        let vc = storyboard?.instantiateViewController(identifier: "SelectCategoryViewController") as! SelectCategoryViewController
        let vc = storyboard?.instantiateViewController(identifier: "CategorySelectViewController") as! CategorySelectViewController
        vc.modalPresentationStyle = .fullScreen
        
        navigationController?.pushViewController(vc, animated: true)
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
        } else if enterDisorderTextField.isFirstResponder {
            enterDisorderTextField.text = disorders[row]
        }
    }
    
    func createPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        enterGradeTextField.inputView = pickerView
        enterDisorderTextField.inputView = pickerView
    }
    
    func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.action))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        enterGradeTextField.inputAccessoryView = toolBar
        enterDisorderTextField.inputAccessoryView = toolBar
    }
    
    @objc func action() {
       view.endEditing(true)
        
        if let gradeText = enterGradeTextField.text,
            let disorderText = enterDisorderTextField.text {
            if !gradeText.isEmpty && disorderText.isEmpty {
            enterAgeTextField.becomeFirstResponder()
            }
        }
    }
}
