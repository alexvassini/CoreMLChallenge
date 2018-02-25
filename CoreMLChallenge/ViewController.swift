//
//  ViewController.swift
//  CoreMLChallenge
//
//  Created by Alexandre  Vassinievski on 20/02/2018.
//  Copyright © 2018 Vassini. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController {

  @IBOutlet weak var mapView: MKMapView!
  
  var locationHelper = LocationHelper()
  let regionRadius: CLLocationDistance = 800
  var lastLocation: CLLocation? {
    didSet{
      centerMapOnLocation(location: lastLocation!)
      //myPosition.coordinate = (lastLocation?.coordinate)!
    }
  }
 // let myPosition = MKPointAnnotation()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    locationHelper.listener = self
    locationHelper.requestLocation(onCompletion:nil)
    //mapView.addAnnotation(myPosition)
  }

  func centerMapOnLocation(location: CLLocation) {
   // let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,regionRadius, regionRadius)
    
    let region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001))
    
    mapView.setRegion(region, animated: true)
  }

}


extension ViewController: LocationHelperListener {
  func didUpdateLocation(lastLocation: CLLocation) {
    self.lastLocation = lastLocation
  }
  
}
