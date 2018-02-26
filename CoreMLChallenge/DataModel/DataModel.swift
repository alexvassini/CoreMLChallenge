//
//  DataModel.swift
//  CoreMLChallenge
//
//  Created by Alexandre  Vassinievski on 25/02/2018.
//  Copyright © 2018 Vassini. All rights reserved.
//

import Foundation
import UIKit

class DataModel {
    static let shared = DataModel()
  
  var imagesDirectoryPath:String!

    //Save croped image in app storage
    
  func saveImage(image: UIImage) -> String {
    
    let title = String(Date().timeIntervalSince1970)
    
    //create an instance of the FileManager
    let fileManager = FileManager.default
    //get the image path
    let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(title)
    
    //get the PNG data for this image
    let data = UIImagePNGRepresentation(image)
    //store it in the document directory
    
    fileManager.createFile(atPath: imagePath as String, contents: data, attributes: nil)
    
    return imagePath
    
  }
    
    
    //load image from  app storage
    
    func loadImageFromPath(imageName: String) -> UIImage? {
      
      let fileManager = FileManager.default
      let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageName)
      
      if fileManager.fileExists(atPath: imagePath){
        return UIImage(contentsOfFile: imagePath)
      }
      else{
        print("Panic! No Image!")
        return nil
      }
    }

  
}



