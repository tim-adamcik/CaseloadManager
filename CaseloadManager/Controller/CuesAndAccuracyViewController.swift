//
//  CuesAndAccuracyViewController.swift
//  CaseloadManager
//
//  Created by Timothy Adamcik on 7/24/20.
//  Copyright © 2020 Timothy Adamcik. All rights reserved.
//

import Foundation
import UIKit

class CuesAndAccuracyViewController: UIViewController {
    
    @IBOutlet var cueLevelBtns: [UIButton]!
    @IBOutlet var cueTypeBtns: [UIButton]!
    @IBOutlet var accuracyBtns: [UIButton]!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var goalLabel: UILabel!
    
    var goalString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goalLabel.text = "Client will " + goalString!
        setUpBtns(btns: cueLevelBtns)
        setUpBtns(btns: cueTypeBtns)
        setUpBtns(btns: accuracyBtns)
    }
    
    func setUpBtns(btns: [UIButton]) {
        for btn in btns {
            btn.backgroundColor = .lightGray
            btn.setTitleColor(UIColor(red: 54, green: 69, blue: 79, alpha: 1), for: .normal)
            btn.layer.cornerRadius = 25
            btn.layer.borderWidth = 1.0
            btn.layer.borderColor = UIColor.darkGray.cgColor
        }
    }
    
    @IBAction func cueLevelSelected(_ sender: Any) {
        
    }
    @IBAction func cueTypeSelected(_ sender: Any) {
    }
    
    @IBAction func accuracySelected(_ sender: Any) {
    }
    
    @IBAction func saveGoalPressed(_ sender: Any) {
    }
    
    
}
