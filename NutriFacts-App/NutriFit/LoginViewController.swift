//
//  LoginViewController.swift
//  NutriFacts
//
//  Created by Iris Chen on 2020-05-02.
//  Copyright © 2020 Denis Tatar. All rights reserved.
//

import UIKit
import FirebaseAuth

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
    
    
    
    @IBAction func loginTapped(_ sender: Any) {
        // Validate Text Fields
        
        // Create cleaned textfields
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Signing in the user
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if error != nil {
                // Couldn't sign in
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
            } else {
                // No error, successful transition
                let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
                
                self.view.window?.rootViewController = homeViewController
                self.view.window?.makeKeyAndVisible()
                
            }
        }
    }
    
    
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
