//
//  CategorySelectViewController.swift
//  CaseloadManager
//
//  Created by Timothy Adamcik on 7/24/20.
//  Copyright © 2020 Timothy Adamcik. All rights reserved.
//

import Foundation
import UIKit

class CategorySelectViewController: UIViewController {
    
    @IBOutlet weak var clientWillLabel: UILabel!
    @IBOutlet weak var selectCategoryTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    let categories = ["Select Category","Custom", "Articulation", "Phonology", "Receptive Language", "Expressive Language", "Hearing", "AAC", "Pragmatics", "Dysphagia", "Fluency", "Voice", "Cognition"]
    var currentArray: [String]? = []
    var currentCategory: String?
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectCategoryTextField.textAlignment = .center
        tableView.delegate = self
        tableView.dataSource = self
        createPickerView()
        dismissPickerView()
    }
    
}

extension CategorySelectViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentArray?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategorySelectCell") as! CategorySelectCell
        
        if currentCategory!.isEmpty {
            cell.label.text = "Please Select a Category"
        } else {
            cell.label.text = currentArray![indexPath.row]
            }
        return cell
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "CuesAndAccuracyViewController") as! CuesAndAccuracyViewController
        vc.modalPresentationStyle = .fullScreen
        let cell = tableView.cellForRow(at: indexPath)
        if let goal = cell?.textLabel?.text {
            vc.goalString = goal
        }
        navigationController?.pushViewController(vc, animated: true)
    }
        
    }
    
    


extension CategorySelectViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectCategoryTextField.text = categories[row]
    }
    
    func createPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        selectCategoryTextField.inputView = pickerView
        
    }
    
    func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.action))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        selectCategoryTextField.inputAccessoryView = toolBar
    }
    
    @objc func action() {
        currentCategory = selectCategoryTextField.text
        currentArray = getCurrentArray(category: currentCategory!)
       view.endEditing(true)
        tableView.reloadData()
    }
    
    func getCurrentArray(category: String) -> [String] {
        switch currentCategory {
        case "Custom":
            return GoalArrays.customGoals
        case "Articulation":
            return GoalArrays.articulationGoals
        case "Phonology":
            return GoalArrays.phonologyGoals
        case "Receptive Language":
            return GoalArrays.receptiveLanguageGoals
        case "Expressive Language":
            return GoalArrays.expressiveLanguageGoals
        case "Hearing":
            return GoalArrays.hearingGoals
        case "AAC":
            return GoalArrays.aacGoals
        case "Pragmatics":
            return GoalArrays.pragmaticGoals
        case "Dysphagia":
            return GoalArrays.dysphagiaGoals
        case "Fluency":
            return GoalArrays.fluencyGoals
        case "Voice":
            return GoalArrays.voiceGoals
        case "Cognition":
            return GoalArrays.cognitiveGoals
        default:
            return [""]
        }
    }
    
    
}
