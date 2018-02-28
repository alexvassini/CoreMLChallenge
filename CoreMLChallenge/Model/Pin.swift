//
//  Pin.swift
//  CoreMLChallenge
//
//  Created by Alexandre  Vassinievski on 25/02/18.
//  Copyright © 2018 Vassini. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

struct Pin: Mappable {
 
  
  
  var latitude: Double?
  var longitude: Double?
  var description: String?
  var image: UIImage?
  var imagePath: String?
  
  init?(map: Map) {
   
  }
  
  init(latitude: Double, longitude: Double, description: String, image: UIImage, imagePath: String) {
    self.latitude = latitude
    self.longitude = longitude
    self.image = image
    self.imagePath = imagePath
    self.description = description
  }
  
  mutating func mapping(map: Map) {
    latitude <- map["latitute"]
    longitude <- map["longitude"]
    description <- map["description"]
    imagePath <- map["imagePath"]
  }
}


