//
//  LoginViewController.swift
//  NutriFacts
//
//  Created by Iris Chen on 2020-05-02.
//  Copyright © 2020 Denis Tatar. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    

    @IBAction func backButton(_ sender: Any) {
        self.performSegue(withIdentifier: "ToHome", sender: self)
    }
    
    @IBAction func signUpButton(_ sender: Any) {
    }
    // Textfields
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBOutlet weak var errorLabel: UILabel!
    
    
    @IBOutlet weak var loginButton: UIButton!
  
    
    @IBAction func logInFacebook(_ sender: Any) {
    }
    
    @IBAction func logInGoogle(_ sender: Any) {
    }
    
    func setUpElements () {
        // Hide the error label
        errorLabel.alpha = 0
        
        // Style the elements
        // Utilities.styleTextField(emailTextField)
        // Utilities.styleTextField(passwordTextField)
        // Utilities.styleFilledButton(loginButton)
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
