//
//  JLocationHelper.swift


import Foundation
import CoreLocation
import UIKit

protocol LocationHelperListener {
  
  func didUpdateLocation(lastLocation : CLLocation)
  
}

class LocationHelper : NSObject, CLLocationManagerDelegate {
  
  var locationManager: CLLocationManager!
  var listener : LocationHelperListener?
  var onCompletion: ((CLLocationCoordinate2D?) -> ())?
  
  override init () {
    locationManager = CLLocationManager()
  }
  
  func requestLocation(onCompletion: ((CLLocationCoordinate2D?) -> ())?) {
    self.locationManager.requestAlwaysAuthorization()
    
    // For use in foreground
    self.locationManager.requestWhenInUseAuthorization()
    if CLLocationManager.locationServicesEnabled() {
      locationManager.delegate = self
      locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
      locationManager.startUpdatingLocation()
    }
    
    self.onCompletion = onCompletion
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if UIApplication.shared.applicationState != .active {return}
    let locValue:CLLocationCoordinate2D? = manager.location?.coordinate
    onCompletion?(locValue)
    self.listener?.didUpdateLocation(lastLocation: locations.last!)
    manager.stopUpdatingLocation()
    self.onCompletion = nil
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(30)) {
    manager.startUpdatingLocation()
    }
  }
}

protocol LocationHelperDelegate {
  func didChangeLocation(location: CLLocation?)
}

class BackgroundLocationHelper: NSObject, CLLocationManagerDelegate {
  
  var locationManager: CLLocationManager!
  
  var delegate: LocationHelperDelegate?
  
  
  override init () {
    locationManager = CLLocationManager()
  }
  
  func requestLocation() {
    self.locationManager.requestAlwaysAuthorization()
    
    // For use in foreground
    self.locationManager.requestWhenInUseAuthorization()
    if CLLocationManager.locationServicesEnabled() {
      locationManager.delegate = self
      locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters //kCLLocationAccuracyKilometer
      locationManager.distanceFilter = 100
      locationManager.startMonitoringSignificantLocationChanges()
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if UIApplication.shared.applicationState == .active {return}
    self.delegate?.didChangeLocation(location: manager.location)
  }
}
