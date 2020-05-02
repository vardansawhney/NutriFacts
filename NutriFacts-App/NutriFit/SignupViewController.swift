//
//  SecondViewController.swift
//  NutriFit
//
//  Created by Denis Tatar on 2020-05-02.
//  Copyright © 2020 Denis Tatar. All rights reserved.
//

import UIKit


class SignupViewController: UIViewController {
    
    // email and password for signup
    // email
    @IBOutlet weak var EmailTextField: UITextField!
    
    // password
    @IBOutlet weak var PasswordTextField: UITextField!
    
    @IBOutlet weak var SignupButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func back_button(_ sender: Any) {
        self.performSegue(withIdentifier: "backToHome", sender: self)
    }
    
    @IBAction func TestButton(_ sender: Any) {
        self.performSegue(withIdentifier: "ToScan", sender: self)
    }
    
    // handle sign up button tap
    
    @IBAction func SignupTapped(_ sender: Any) {
    }
    
}
