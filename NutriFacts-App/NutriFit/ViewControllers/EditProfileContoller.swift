//
//  EditProfileContoller.swift
//  NutriFacts
//
//  Created by Denis Tatar on 2020-05-09.
//  Copyright © 2020 Denis Tatar. All rights reserved.
//

import UIKit

class EditProfileController: UIViewController {
        
    @IBAction func logOutButton(_ sender: Any) {
        self.performSegue(withIdentifier: "toHome", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        print(data)
    }
}
