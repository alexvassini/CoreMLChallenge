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

class ViewController: UIViewController, FinishCreation, MKMapViewDelegate {

  @IBOutlet weak var mapView: MKMapView!
  
  var locationHelper = LocationHelper()
  let regionRadius: CLLocationDistance = 800
    
    var pins: [Pin] = []
    
    
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        let annotations = self.mapView.annotations
        self.mapView.removeAnnotations(annotations)
        
        
        pins.forEach { pin in
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: pin.latitude, longitude: pin.longitude)
            annotation.subtitle = pin.description
            self.mapView.addAnnotation(annotation)
        }
    }

  func centerMapOnLocation(location: CLLocation) {
    
    let region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    
    mapView.setRegion(region, animated: true)
  }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let description = view.annotation!.subtitle!
        self.pins.forEach { (pin) in
            if pin.description == description {
                //go to detail screen
            }
        }
    }
    
    func didFinish(_ pin: Pin) {
        self.pins.append(pin)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToCameraView" {
            let destination = segue.destination as! CameraViewController
            destination.latitude = (self.lastLocation?.coordinate.latitude)!
            destination.longitude = (self.lastLocation?.coordinate.longitude)!
            destination.delegate = self
        }
        
    }

}


extension ViewController: LocationHelperListener {
  func didUpdateLocation(lastLocation: CLLocation) {
    self.lastLocation = lastLocation
  }
  
}
