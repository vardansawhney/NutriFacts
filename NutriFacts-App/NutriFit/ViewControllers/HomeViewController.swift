
// home view controller and scanning

import UIKit
import VisionKit
import Vision
import Foundation

class HomeViewController: UIViewController, VNDocumentCameraViewControllerDelegate {
    
    // constants for the view controller
    let textRecognitionWorkQueue = DispatchQueue(label: "TextRecognitionQueue", qos: .userInitiated, attributes: [], autoreleaseFrequency: .workItem)
    
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
        var detectedText = ""

        for observation in observations {
            guard let topCandidate = observation.topCandidates(1).first else { return }

            // string to contain parsed data
            detectedText += topCandidate.string
            detectedText += "\n"
            print("New Detected Material:")
            print(detectedText)
        }
    }
    @IBOutlet weak var viewScanButton: UIButton!
    
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

