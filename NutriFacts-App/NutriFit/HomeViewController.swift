
// home view controller and scanning

import UIKit
import VisionKit
import Vision

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
    
    private func configureDocumentView() {
        let documentCameraViewController = VNDocumentCameraViewController()
        documentCameraViewController.delegate = self
        present(documentCameraViewController, animated: true, completion: nil)
    }
    
    var textRecognitionRequest = VNRecognizeTextRequest { (request, error) in
        guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
        var detectedText = ""

        // Vision will separate each line, phrase or sentence automatically into separate observations, which we can iterate over
        for observation in observations {
            // Each observation contains a list of possible 'candidates' that the observation could be, such as ['lol', '1o1', '101']
            // We can ask for all the topCandidates up to a certain limit.
            // Each candidate contains the string and the confidence level that it is accurate.
            guard let topCandidate = observation.topCandidates(1).first else { return }

            detectedText += topCandidate.string
            detectedText += "\n"
        }
    }
    
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

