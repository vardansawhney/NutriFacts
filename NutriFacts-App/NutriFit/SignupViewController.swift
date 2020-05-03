//
//  SecondViewController.swift
//  NutriFit
//
//  Created by Denis Tatar on 2020-05-02.
//  Copyright © 2020 Denis Tatar. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

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
    
    
    // Method to validate the fields
    // Checking fields and validate if data is correct. If everything is correct
    // function returns nil. Otherwise, it returns the error message as a string
    func validateFields() -> String? {
        // Check all fields are filled in
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        EmailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        PasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields"
        }
        
        // Check if the password is secure
        // Method can be found in "Utilities"
        let cleanedPassword = PasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isPasswordValid(cleanedPassword) == false {
            // Password isn't secured enough!
            return "Please make sure your password is at least 8 characters, contains a special character and a number!"
        }
        
        return nil
    }
    
    @IBAction func SignupTapped(_ sender: Any) {
        // Validate the fields
        let error = validateFields()
        
        // ERROR CHECKING!
        if error != nil {
            // There's something wrong with the fields, show error message
            showError(error!)
        } else {
            
            // Let's create cleaned versions of the data
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = EmailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = PasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
             // Create the user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                // Check for errors
                if err != nil {
                    
                    // There was an error creating the user
                    self.showError("Error creating user")
                } else {
                    
                    // User was created successfully, now store the first name and last name
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: ["firstname": firstName, "lastname": lastName, "uid": result!.user.uid]) { (error) in
                        
                        if error != nil {
                            // Show error message
                            self.showError("Erro saving user data" )
                        }
                    }
                    
                    // Transition to the homescreen
                    self.transitionToHome()
                }
            }
             
        }
    }
    
    // Function to display error (moving here so it's easier to call on)
    func showError(_ message:String){
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    
    func transitionToHome() {
        
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
        
    }

    
}
