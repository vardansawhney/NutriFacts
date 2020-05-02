//
//  ViewController.swift
//  NutriFit
//
//  Created by Denis Tatar on 2020-05-02.
//  Copyright © 2020 Denis Tatar. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func log_in(_ sender: Any) {
        print("Login is printed")
    }
    
    @IBAction func sign_up(_ sender: Any) {
        self.performSegue(withIdentifier: "SecondViewSegue", sender: self)
        print("Signup is printed")
    }
}

