//
//  CameraViewController.swift
//  CoreMLChallenge
//
//  Created by Alexandre  Vassinievski on 25/02/2018.
//  Copyright © 2018 Vassini. All rights reserved.
//

import UIKit
import Photos

class CameraViewController: UIViewController {
  
  @IBOutlet fileprivate var captureButton: UIButton!
  
  ///Displays a preview of the video output generated by the device's cameras.
  @IBOutlet fileprivate var capturePreviewView: UIView!
  
  ///Allows the user to put the camera in photo mode.
  @IBOutlet fileprivate var photoModeButton: UIButton!
  @IBOutlet fileprivate var toggleCameraButton: UIButton!
  @IBOutlet fileprivate var toggleFlashButton: UIButton!
  
  let cameraController = CameraHelper()
  
  override var prefersStatusBarHidden: Bool { return true }
  
}

extension CameraViewController {
  override func viewDidLoad() {
    
    func configureCameraController() {
      cameraController.prepare {(error) in
        if let error = error {
          print(error)
        }
        
        try? self.cameraController.displayPreview(on: self.capturePreviewView)
      }
    }
    
    func styleCaptureButton() {
      captureButton.layer.borderColor = UIColor.black.cgColor
      captureButton.layer.borderWidth = 2
      
      captureButton.layer.cornerRadius = min(captureButton.frame.width, captureButton.frame.height) / 2
    }
    
    styleCaptureButton()
    configureCameraController()
    
  }
}

extension CameraViewController {
  @IBAction func toggleFlash(_ sender: UIButton) {
    if cameraController.flashMode == .on {
      cameraController.flashMode = .off
      toggleFlashButton.setImage(#imageLiteral(resourceName: "Flash Off Icon"), for: .normal)
    }
      
    else {
      cameraController.flashMode = .on
      toggleFlashButton.setImage(#imageLiteral(resourceName: "Flash On Icon"), for: .normal)
    }
  }
  
  @IBAction func switchCameras(_ sender: UIButton) {
    do {
      try cameraController.switchCameras()
    }
      
    catch {
      print(error)
    }
    
    switch cameraController.currentCameraPosition {
    case .some(.front):
      toggleCameraButton.setImage(#imageLiteral(resourceName: "Front Camera Icon"), for: .normal)
      
    case .some(.rear):
      toggleCameraButton.setImage(#imageLiteral(resourceName: "Rear Camera Icon"), for: .normal)
      
    case .none:
      return
    }
  }
  
  @IBAction func captureImage(_ sender: UIButton) {
    cameraController.captureImage {(image, error) in
      guard let image = image else {
        print(error ?? "Image capture error")
        return
      }
      //Convert to PixelBuffer
      
      // Test on CoreML
      
      //Save
      DataModel.shared.saveImage(image: image, title: "Teste")
      
      let imagem = DataModel.shared.loadImageFromPath(imageName: "Teste")
      let imageView = UIImageView(image: imagem)
      self.view.addSubview(imageView)
    //  DataModel.shared.loadImageFromPath(imageName: "Teste")
   //   try? PHPhotoLibrary.shared().performChangesAndWait {
      //  PHAssetChangeRequest.creationRequestForAsset(from: image)
     // }
    }
  }
  
}


