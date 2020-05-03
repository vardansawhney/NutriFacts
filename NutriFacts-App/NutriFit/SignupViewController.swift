//
//  SecondViewController.swift
//  NutriFit
//
//  Created by Denis Tatar on 2020-05-02.
//  Copyright © 2020 Denis Tatar. All rights reserved.
//

import UIKit


class SignupViewController: UIViewController {
    
    // First and last name fields
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    // email and password for signup
    // email
    @IBOutlet weak var EmailTextField: UITextField!
    
    // password
    @IBOutlet weak var PasswordTextField: UITextField!
    
    @IBOutlet weak var SignupButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    // This function is important!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setUpElements()
    }
    
    // Setting up our Sign up view correctly
    func setUpElements () {
        // Hiding the error label
        errorLabel.alpha = 0
        
        // Style the elements
        // Utilities.styleTextField(firstNameTextField)
        // Utilities.styleTextField(lastNameTextField)
        // Utilities.styleTextField(EmailTextField)
        // Utilities.styleTextField(PasswordTextField)
        // Utilities.styleFilledButton(SignupButton)
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
    
    //
    
}
