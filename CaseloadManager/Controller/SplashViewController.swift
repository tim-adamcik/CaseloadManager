//
//  SplashViewController.swift
//  CaseloadManager
//
//  Created by Timothy Adamcik on 7/17/20.
//  Copyright © 2020 Timothy Adamcik. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        openToLogin()
    }
    
    private func openToLogin() {
        let vc = storyboard?.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
        vc.modalPresentationStyle = .fullScreen
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            self.present(vc, animated: true)
        }
        
    }


}

