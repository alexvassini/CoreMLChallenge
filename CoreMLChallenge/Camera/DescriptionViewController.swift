//
//  DescriptionViewController.swift
//  CoreMLChallenge
//
//  Created by Alexandre  Vassinievski on 25/02/18.
//  Copyright © 2018 Vassini. All rights reserved.
//

import UIKit

protocol FinishCreation {
    func didFinish(_ pin: Pin)
}

class DescriptionViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var descriptionTextField: UITextView!
    
    var delegate: FinishCreation?
    
    var pin: Pin?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.imageView.image = self.pin?.image
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func doneButton(_ sender: Any) {
        self.pin?.description = self.descriptionTextField.text
        
        self.delegate?.didFinish(self.pin!)
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    

}
