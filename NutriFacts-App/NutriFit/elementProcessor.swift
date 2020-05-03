//
//  elementProcessor.swift
//  NutriFacts
//
//  Created by Vardan Sawhney on 2020-05-02.
//  Copyright © 2020 Denis Tatar. All rights reserved.
//

//import Foundation
//import Firebase

/*
 //detecting the frames
struct ScaledElement {
  let frame: CGRect
  let shapeLayer: CALayer
}

class elementProcessor {
    let vision = Vision.vision()
    var textRecognizer: VisionTextRecognizer!
    
    init() {
        textRecognizer = vision.onDeviceTextRecognizer()
    }
//array of scaledElements + text
  func process(in imageView: UIImageView, callback: @escaping (_ text: String, _ scaledElements: [ScaledElement]) -> Void) {
    //check for an image
    guard let image = imageView.image else { return }
    //visionImage type according to docs
    let visionImage = VisionImage(image: image)
    //process method for visionimage -> return array
    textRecognizer.process(visionImage) { result, error in
      guard error == nil, let result = result, !result.text.isEmpty else {
        callback("", [])
        return
      }
      //collection for frames and shape layers
      var scaledElements: [ScaledElement] = []
 //parse line by line
      for block in result.blocks {
        for line in block.lines {
          for element in line.elements {
        //creates shape layer from elements frame to construct new scaledElementinstance
            let frame = self.createScaledFrame(featureFrame: element.frame, imageSize: image.size, viewFrame: imageView.frame)
            
            let shapeLayer = self.createShapeLayer(frame: frame)
            let scaledElement = ScaledElement(frame: frame, shapeLayer: shapeLayer)
           //add to scaledElements
            scaledElements.append(scaledElement)
          }
        }
      }
      
      callback(result.text, scaledElements)
    }
  }

  private func createShapeLayer(frame: CGRect) -> CAShapeLayer {
 //construct UIBezierPath with CGRect to set layer's path to UIBezierPath
    let bpath = UIBezierPath(rect: frame)
    let shapeLayer = CAShapeLayer()
 //colours visualproperties
    shapeLayer.path = bpath.cgPath
    shapeLayer.strokeColor = Constants.lineColor
    shapeLayer.fillColor = Constants.fillColor
    shapeLayer.lineWidth = Constants.lineWidth
    return shapeLayer
  }
  
  private func createScaledFrame(featureFrame: CGRect, imageSize: CGSize, viewFrame: CGRect) -> CGRect {
    let viewSize = viewFrame.size
    
    let resolutionView = viewSize.width / viewSize.height
    let resolutionImage = imageSize.width / imageSize.height
    
    var scale: CGFloat
    if resolutionView > resolutionImage {
      scale = viewSize.height / imageSize.height
    } else {
      scale = viewSize.width / imageSize.width
    }
    
    let featureWidthScaled = featureFrame.size.width * scale
    let featureHeightScaled = featureFrame.size.height * scale
    
    let imageWidthScaled = imageSize.width * scale
    let imageHeightScaled = imageSize.height * scale
    let imagePointXScaled = (viewSize.width - imageWidthScaled) / 2
    let imagePointYScaled = (viewSize.height - imageHeightScaled) / 2
    
    let featurePointXScaled = imagePointXScaled + featureFrame.origin.x * scale
    let featurePointYScaled = imagePointYScaled + featureFrame.origin.y * scale
    
    return CGRect(x: featurePointXScaled, y: featurePointYScaled, width: featureWidthScaled, height: featureHeightScaled)
  }

  // MARK: - private
  //consistency in the shapes
  private enum Constants {
    static let lineWidth: CGFloat = 3.0
    static let lineColor = UIColor.yellow.cgColor
    static let fillColor = UIColor.clear.cgColor
  }
}
*/
