//
//  DescriptionPopUp.swift
//  CoreMLChallenge
//
//  Created by Alexandre  Vassinievski on 26/02/2018.
//  Copyright © 2018 Vassini. All rights reserved.
//

import UIKit

class DescriptionPopUp: UIView {
  
  @IBOutlet weak var contentView: UIView!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var imageView: UIImageView!
  
  var view: UIView!
  var pin: Pin!
  var okCompletion: (() -> ())?
  
  var ypos : CGFloat {
    get {
      return self.frame.size.height / 2 + self.view.frame.size.height / 2
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
  }
  
  override func didMoveToSuperview() {
    self.descriptionLabel.text = pin.description
    self.imageView.image = DataModel.shared.loadImageFromPath(imagePath: pin.imagePath!)
  }
  
  init(frame: CGRect, pin: Pin) {
    super.init(frame: frame)
    
    self.pin = pin
    xibSetup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    xibSetup()
  }
  
  func xibSetup() {
    view = instanceFromNib()
    view.frame = bounds
    view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    addSubview(view)

  }
  
  func instanceFromNib() -> UIView {
    let nibView = UINib(nibName: "DescriptionPopUp", bundle: Bundle(for: type(of: self))).instantiate(withOwner: self, options: nil)[0] as! UIView
    return nibView
  }
  
  func showInView(view:UIView?) {
    guard let view = view else {
      return
    }
    self.alpha = 0.1
    self.view.frame.origin.y = self.frame.height
    view.addSubview(self)
    layoutIfNeeded()
    UIView.animate(withDuration: 0.5) {
      self.view.center.y = self.frame.midY
      self.alpha = 1.0
    }
  }
  
  /**
   Hide the popup view with completion callback
   
   - parameter completion: A completion callback function
   */
  func hide(_ completion: @escaping () -> ()) {
    UIView.animate(withDuration: 0.5, animations: { () -> Void in
      self.view.center.y = self.frame.height
      self.alpha = 0.0
    }, completion: { (finished) -> Void in
      self.removeFromSuperview()
      completion()
    })
  }
  
  @IBAction func okAction(_ sender: Any) {
    hide {
      self.okCompletion?()
    }
  }
  
  
}
