
// home view controller and scanning

import UIKit
import VisionKit
import Vision
import Foundation

class HomeViewController: UIViewController, VNDocumentCameraViewControllerDelegate {
    
    // constants for the view controller
    let textRecognitionWorkQueue = DispatchQueue(label: "TextRecognitionQueue", qos: .userInitiated, attributes: [], autoreleaseFrequency: .workItem)
    // global variable for everything scanned
//    let detectedText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    func setUpElements () {

    }
    
    // HOME/ROOT view:
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var logInButton: UIButton!
    
    @IBAction func signUpButton(_ sender: Any) {
        self.performSegue(withIdentifier: "SecondViewSegue", sender: self)
    }
    
    @IBAction func logInButton(_ sender: Any) {
        self.performSegue(withIdentifier: "ToLogIn", sender: self)
    }
    
    
    // Scanning:
    
    // view scan button
    @IBAction func viewScanButt(_ sender: Any) {
        self.performSegue(withIdentifier: "ToData1", sender: self)
    }
    
    @IBAction func scan(_ sender: Any) {
        configureDocumentView()
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
        var local_detected_text = ""
        for observation in observations {
            guard let topCandidate = observation.topCandidates(1).first else { return }

            // string to contain parsed data
            local_detected_text += topCandidate.string
            local_detected_text += "\n"
        }
        // the last detected text is the one you want
        // fat, cholesterol, sodium, carbohydrate, protein, and iron
        let detected_array = local_detected_text.components(separatedBy: "\n")
        let default_intake = "0%"
        var nutrient_dict =
        [
            "Fat" : default_intake,
            "Cholesterol" : default_intake,
            "Sodium": default_intake,
            "Carbohydrate": default_intake,
            "Protein": default_intake,
            "Iron": default_intake
        ]
        
        // populate if percentage daily values exist
        for (index, line) in detected_array.enumerated() {

            if (line.contains("Fat")) {
                var percentage_intake = detected_array[index+1]
                if (percentage_intake.contains("%")) {
                    nutrient_dict["Fat"] = percentage_intake
                }
            } else if (line.contains("Cholesterol")) {
                var percentage_intake = detected_array[index+1]
                if (percentage_intake.contains("%")) {
                    nutrient_dict["Cholesterol"] = percentage_intake
                }
            } else if (line.contains("Sodium")) {
                var percentage_intake = detected_array[index+1]
                if (percentage_intake.contains("%")) {
                    nutrient_dict["Sodium"] = percentage_intake
                }
            } else if (line.contains("Carbohydrate")) {
                var percentage_intake = detected_array[index+1]
                if (percentage_intake.contains("%")) {
                    nutrient_dict["Carbohydrate"] = percentage_intake
                }
            } else if (line.contains("Protein")) {
                var percentage_intake = detected_array[index+1]
                if (percentage_intake.contains("%")) {
                    nutrient_dict["Protein"] = percentage_intake
                }
            } else if (line.contains("Iron")) {
                var percentage_intake = detected_array[index+1]
                if (percentage_intake.contains("%")) {
                    nutrient_dict["Iron"] = percentage_intake
                }
            }
        }
//    dump(nutrient_dict)
    }
    
    @IBOutlet weak var viewScanButton: UIButton!
    
    // handler for parsing
    private func recognizeTextInImage(_ image: UIImage) {
        guard let cgImage = image.cgImage else { return }

        textRecognitionWorkQueue.async {
            let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
            do {
                try requestHandler.perform([self.textRecognitionRequest])
//                print(detectedText)
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

// sample data:
/* ["Nutrition", "Facts", "Valeur", "nutritive", "Per 2 cookies (23 g) / Pour 2 biscuits (23 g)", "Amount", "% Daily Value", "Teneur", "% valeur quotidienne", "Calories / Calories 100", "Fat / Lipides 3.0 g", "5 %", "Saturated / saturés 0.5 g", "3 %", "+ Trans / trans 0 g", "Cholesterol / Cholestérol 0 mg", "0 %", "Sodium / Sodium 75 mg", "3 %", "Carbohydrate / Glucides 18 g", "6 %", "Fibre / Fibres 0 g", "0 %", "Sugars / Sucres 10 g", "Protein / Protéines 1 g", "Vitamin A / Vitamine A", "0 %", "Vitamin C / Vitamine C", "0 %", "Calcium / Calcium", "0 %", "Iron / Fer", "8 %", ""]
[:]


▿ 6 key/value pairs
  ▿ (2 elements)
    - key: "Fat"
    - value: "5 %"
  ▿ (2 elements)
    - key: "Sodium"
    - value: "3 %"
  ▿ (2 elements)
    - key: "Cholesterol"
    - value: "0%"
  ▿ (2 elements)
    - key: "Protein"
    - value: "0%"
  ▿ (2 elements)
    - key: "Carbohydrate"
    - value: "6 %"
  ▿ (2 elements)
    - key: "Iron"
    - value: "8 %"
*/
