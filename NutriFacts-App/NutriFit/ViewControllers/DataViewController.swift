//
//  DataViewController.swift
//  NutriFacts
//
//  Created by Denis Tatar on 2020-05-03.
//  Copyright © 2020 Denis Tatar. All rights reserved.
//


import UIKit
//import Charts

class DataViewController: UIViewController {
    
    @IBOutlet weak var scan_label: UILabel!
    
    var data = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scan_label.text = data
    }
}

