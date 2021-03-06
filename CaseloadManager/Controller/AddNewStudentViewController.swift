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
    @IBOutlet weak var studentIDLabel: UILabel!
    @IBOutlet weak var studentIDTextField: UITextField!
    @IBOutlet weak var treatmentMinutesTextField: UITextField!
    
    
    var activeTextField: UITextField? = nil
    let disorders = ["Select Disorder","Speech", "Language", "Speech and Language", "Cognitive Impairment", "Dysphagia"]
    let grades = ["Select Grade","Early Childhood", "Pre-K", "K", "1","2","3","4","5","6","7","8","9","10","11","12","Adult"]
    var pickerView = UIPickerView()
    let datePicker = UIDatePicker()
    var goals: [GoalMade] = []
    var currentAgeGroup: AgeGroup?
    
    
   lazy var saveStudentBtn: UIBarButtonItem = {
       let barBtnItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveStudentBtnPressed(_:)))
       return barBtnItem
   }()
    
    lazy var cancelBtn: UIBarButtonItem = {
        let barBtnItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelBtnPressed(_:)))
        return barBtnItem
    }()
    
    fileprivate func createTextFieldAndPickerDelegates() {
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        enterAgeTextField.delegate = self
        studentIDTextField.delegate = self
        treatmentMinutesTextField.delegate = self
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
        navigationItem.leftBarButtonItem = cancelBtn
        navigationItem.rightBarButtonItem = saveStudentBtn
        createTextFieldAndPickerDelegates()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60

        
        NotificationCenter.default.addObserver(self, selector: #selector(AddNewStudentViewController.keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AddNewStudentViewController.keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didGetNotification(_:)), name: Notification.Name("goal"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    @objc func didGetNotification(_ notification: Notification) {
        if let goal = notification.object as! GoalMade? {
          goals.append(goal)
        }
        tableView.reloadData()
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
    
    @objc func saveStudentBtnPressed(_ sender: Any) {
        
        if lastNameTextField.text?.isEmpty ?? true {
            displayAlertMessage(userMessage: "Please Enter Last Name")
            return
        } else if firstNameTextField.text?.isEmpty ?? true {
            displayAlertMessage(userMessage: "Please Enter First Name")
            return
        }
        
        let newStudent = Student(context: CoreDataStack.shared.managedContext)
        newStudent.ageGroup = currentAgeGroup
        newStudent.firstName = firstNameTextField.text!
        newStudent.lastName = lastNameTextField.text!
        newStudent.grade = enterGradeTextField.text
        if let ageInt = Int16(enterAgeTextField.text!) {
            newStudent.age = ageInt
        }
        newStudent.studentID = studentIDTextField.text
        newStudent.caseManager = enterCaseManagerTextField.text
        newStudent.endDate = datePicker.date as Date
        newStudent.disorder = enterDisorderTextField.text
        newStudent.sessionLength = treatmentMinutesTextField.text
        
        CoreDataStack.shared.saveContext()
        dismiss(animated: true, completion: nil)
    }
    
    func displayAlertMessage(userMessage: String) {
        let alert = UIAlertController(title: "Error", message: userMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
    
    @objc func cancelBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
        return goals.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GoalTableViewCell") as! GoalTableViewCell
        let goal = goals[indexPath.row]
        cell.goalLabel.text = goal.goal
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

