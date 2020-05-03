
// home view controller and scanning

import UIKit
import VisionKit
import Vision
import Foundation

class HomeViewController: UIViewController, VNDocumentCameraViewControllerDelegate {
    
    // constants for the view controller
//    var textRecognitionRequest = VNRecognizeTextRequest(completionHandler: nil)
    let textRecognitionWorkQueue = DispatchQueue(label: "TextRecognitionQueue", qos: .userInitiated, attributes: [], autoreleaseFrequency: .workItem)
    

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
    
    // SCANNING WITH THE CAMERA
    private func configureDocumentView() {
        let documentCameraViewController = VNDocumentCameraViewController()
        documentCameraViewController.delegate = self
        present(documentCameraViewController, animated: true, completion: nil)
    }
    
    
    // PARSING IMAGES
    var textRecognitionRequest = VNRecognizeTextRequest { (request, error) in
        guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
        var detectedText = ""

        for observation in observations {
            guard let topCandidate = observation.topCandidates(1).first else { return }

            // DETECTED TEXT CONTAINS WHAT YOU NEED
            // THIS IS WHAT YOU NEED!!
            // THIS IS THE PARSED DATA FROM THE IMAGES!! HEREEEEE******
            detectedText += topCandidate.string
            detectedText += "\n"
            print("New Detected Material:")
            print(detectedText)
            
            
            // Creating cleaned out version of this text
            // Sample code
            

            // let newArray = detectedText.components(separatedBy: " ")
            let newArray =  detectedText.replacingOccurrences(of: "\n", with: " ")
            

            // var firstName: String = newArray[0]
            // var lastName: String = newArray[1]
            // print("NEW NAMES:")
            // print(firstName)
            // print(lastName)
            print("New Array:")
            print(newArray)
            
            // Initializing our 6 wanted values
            let iron = 0
            let potassium = 0
            let calcium = 0
            let cholesterol = 0
            let saturated = 0
            let carbohydrates = 0
            
            
            // For loop to go through each component
            print("For loop bitch")
            for label in detectedText.split(separator: " ") {
                
            /*
                if label == "Iron"{
                    label ==
                }
                
                if label == "Potassium"{
                    
                }
                
                if label == "Calcium"{
                    
                }
                
                if label == "Cholesterol"{
                    
                }
                
                if label == "Saturated"{
                    
                }
                
                if label == "Carbohydrates" {
                    
                }
                
 */
            }
            
        }
    }
    
    // handler for parsing
    private func recognizeTextInImage(_ image: UIImage) {
        guard let cgImage = image.cgImage else { return }

        textRecognitionWorkQueue.async {
            let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
            do {
                try requestHandler.perform([self.textRecognitionRequest])
            } catch {
                // lolll
                print(error)
            }
        }
    }
    
}


// on finish scanning calls handler
extension HomeViewController {
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
        for pageNumber in 0..<scan.pageCount {
            let image = scan.imageOfPage(at: pageNumber)
            // scan the image to text
            self.recognizeTextInImage(image)
        }
        controller.dismiss(animated:true, completion: nil)
    }
}

