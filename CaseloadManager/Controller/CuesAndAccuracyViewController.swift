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
    let tintColor: UIColor = UIColor(red: 54/255, green: 69/255, blue: 79/255, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goalLabel.text = "Client will " + goalString!
        setUpDefaultBtns(btns: cueLevelBtns)
        setUpDefaultBtns(btns: cueTypeBtns)
        setUpDefaultBtns(btns: accuracyBtns)
    }
    
    func setUpDefaultBtns(btns: [UIButton]) {
        for btn in btns {
            btn.layer.cornerRadius = 25
            btn.layer.borderWidth = 1.0
            btn.layer.borderColor = UIColor.darkGray.cgColor
        }
    }
    
    
    fileprivate func selectButtons(_ sender: UIButton, btns: [UIButton]) {
        btns.forEach({ $0.backgroundColor = .systemGray6
            $0.isSelected = false
            $0.setTitleColor(tintColor, for: .normal)
        })
        
        sender.backgroundColor = tintColor
        sender.isSelected = true
        sender.setTitleColor(.white, for: .selected)
    }
    
    @IBAction func cueLevelSelected(_ sender: UIButton) {
        selectButtons(sender, btns: cueLevelBtns)
        
    }
    @IBAction func cueTypeSelected(_ sender: UIButton) {
        selectButtons(sender, btns: cueTypeBtns)
    }
    
    @IBAction func accuracySelected(_ sender: UIButton) {
        selectButtons(sender, btns: accuracyBtns)
    }
    
    @IBAction func saveGoalPressed(_ sender: Any) {
    }
    
    
}
