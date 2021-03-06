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
  
  @IBOutlet weak var activittyView: UIView!
  var latitude: Double = 0.0
  var longitude: Double = 0.0
  
  @IBOutlet fileprivate var captureButton: UIButton!
  
  ///Displays a preview of the video output generated by the device's cameras.
  @IBOutlet fileprivate var capturePreviewView: UIView!
  
  ///Allows the user to put the camera in photo mode.
  @IBOutlet fileprivate var photoModeButton: UIButton!
  @IBOutlet fileprivate var toggleCameraButton: UIButton!
  @IBOutlet fileprivate var toggleFlashButton: UIButton!
  
  let cameraController = CameraHelper()
  
  var delegate: FinishCreation?
  var pin: Pin?
  
  override var prefersStatusBarHidden: Bool { return true }
  
}

extension CameraViewController {
  override func viewDidLoad() {
    
    self.activittyView.isHidden = true

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
      self.activittyView.isHidden = false
      guard let image = image else {
        print(error ?? "Image capture error")
        self.activittyView.isHidden = true
        return
      }
      if DataModel.shared.imageIsSafe(image){
        self.activittyView.isHidden = true

        let path = DataModel.shared.saveImage(image: image)
        
        self.pin = Pin(latitude: self.latitude, longitude: self.longitude, description: "", image: image, imagePath: path)
        
        self.performSegue(withIdentifier: "FillDetailScreen", sender: nil)
      }
      
      else {
        self.showUnsafePopUp()
        self.activittyView.isHidden = true
      }
    }
    
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "FillDetailScreen" {
      let destination = segue.destination as! DescriptionViewController
      destination.delegate = self.delegate
      destination.pin = self.pin
    }
  }
  
}


