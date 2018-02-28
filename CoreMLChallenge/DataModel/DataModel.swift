//
//  DataModel.swift
//  CoreMLChallenge
//
//  Created by Alexandre  Vassinievski on 25/02/2018.
//  Copyright © 2018 Vassini. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

class DataModel {
  static let shared = DataModel()
  
  var imagesDirectoryPath:String!
  
  
  //Save croped image in app storage
  
  func saveImage(image: UIImage) -> String {
    
    let title = String(Date().hashValue)
    let imagePath = getDocumentsDirectory().appendingPathComponent(title)
    
    if let data = UIImageJPEGRepresentation(image, 1.0){
       try? data.write(to: imagePath)
    }
    print("Save on: \(imagePath)")
    
    return imagePath.path
    
  }
  

  
  func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
  }
  
  //load image from  app storage
  
  func loadImageFromPath(imagePath: String) -> UIImage? {
    print("Load from: \(imagePath)")
    if let image = UIImage(contentsOfFile: imagePath){
      return image
    }
    else{
      print("Panic! No Image!")
      return nil
    }
  }
  
  func loadPins() -> [Pin]{
    
    var pins: [Pin] = []
    let defaults = UserDefaults.standard
    if let Json = defaults.string(forKey: "Pins"){
      
      pins = Mapper<Pin>().mapArray(JSONString: Json) ?? []
      print(pins)
      print("\n\n pins count:: \(pins.count)")
      
    }

    return pins
  }
  
  func savePins(_ pins:[Pin]){
    let defaults = UserDefaults.standard
    let data = pins.toJSONString()
    defaults.set(data, forKey: "Pins")
  }
  
}



