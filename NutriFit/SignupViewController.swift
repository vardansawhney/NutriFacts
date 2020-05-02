//
//  SecondViewController.swift
//  NutriFit
//
//  Created by Denis Tatar on 2020-05-02.
//  Copyright © 2020 Denis Tatar. All rights reserved.
//

import UIKit


class SignupViewController: UIViewController {

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
    
}
