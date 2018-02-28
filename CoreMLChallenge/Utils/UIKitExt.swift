//
//  UIKitExt.swift
//  CoreMLChallenge
//
//  Created by Alexandre  Vassinievski on 26/02/2018.
//  Copyright © 2018 Vassini. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {

  func displayPopUp(pin: Pin, okCompletion: (()->())? = nil){
    let popUp = DescriptionPopUp(frame: view.frame, pin: pin)
    popUp.showInView(view: view)
    popUp.okCompletion = okCompletion
  }
  
  func showUnsafePopUp(okCompletion: (()->())? = nil){
    let popUp = UnsafePopUp(frame: view.frame)
    popUp.showInView(view: view)
    popUp.okCompletion = okCompletion
  }
}
