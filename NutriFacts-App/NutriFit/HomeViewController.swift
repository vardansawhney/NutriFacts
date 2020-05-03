//
//  ViewController.swift
//  NutriFit
//
//  Created by Denis Tatar on 2020-05-02.
//  Copyright © 2020 Denis Tatar. All rights reserved.
//

import UIKit
import VisionKit

class HomeViewController: UIViewController, VNDocumentCameraViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpElements()
    }


    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var logInButton: UIButton!
    
    // Buttons!
    @IBAction func signUpButton(_ sender: Any) {
        self.performSegue(withIdentifier: "SecondViewSegue", sender: self)
    }
    
    @IBAction func logInButton(_ sender: Any) {
        self.performSegue(withIdentifier: "ToLogIn", sender: self)
    }
    
    @IBAction func scan(_ sender: Any) {
        configureDocumentView()
    }
    
    func setUpElements () {
        // Utilities.styleFilledButton(signUpButton)
        // Utilities.styleFilledButton(logInButton)
    }
    
    private func configureDocumentView() {
        let documentCameraViewController = VNDocumentCameraViewController()
        documentCameraViewController.delegate = self
        present(documentCameraViewController, animated: true, completion: nil)
    }
}


extension HomeViewController {
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
        for pageNumber in 0..<scan.pageCount {
            let image = scan.imageOfPage(at: pageNumber)
            print(image)
        }
        controller.dismiss(animated:true, completion: nil)
    }
}

