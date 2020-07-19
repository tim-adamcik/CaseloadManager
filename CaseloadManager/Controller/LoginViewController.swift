//
//  LoginViewController.swift
//  CaseloadManager
//
//  Created by Timothy Adamcik on 7/17/20.
//  Copyright © 2020 Timothy Adamcik. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    
    func setUpUi() {
        loginBtn.layer.cornerRadius = 5
        loginBtn.layer.borderWidth = 1
        signUpBtn.layer.cornerRadius = 5
        signUpBtn.layer.borderWidth = 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUi()
    }
    
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(identifier: "AgeGroupViewController") as! AgeGroupViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @IBAction func signUpBtnPressed(_ sender: Any) {
    }
    
    
}
