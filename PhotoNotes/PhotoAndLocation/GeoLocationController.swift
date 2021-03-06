//
//  GeoLocationController.swift
//  PhotoNotes
//
//  Created by Иван Лебедев on 18.02.2020.
//  Copyright © 2020 Иван Лебедев. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import MapKit

public protocol GeoLocationDelegate:class{
    func didselect(locatin:CLLocation)
}

open class GeoLocation: NSObject {
    
    
   // var placeMark = MKPlacemark()
    private var finalCoordinate = CLLocationCoordinate2D(latitude: 21.282778, longitude: -157.82944)
    private var finalLocatio = "d"
    private let locationManager: CLLocationManager
    private weak var presentationControllerGeo: UIViewController?
    private weak var delegateGeo: GeoLocationDelegate?
    
    public init(delegate: GeoLocationDelegate, presentationController: UIViewController){
        self.locationManager = CLLocationManager()
        super.init()
        
        self.presentationControllerGeo = presentationController
        self.delegateGeo = delegate
        
        self.locationManager.delegate = self
        self.locationManager.allowsBackgroundLocationUpdates = false
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        
    }
    
    
    
    func checkLocationEnabled(){
        if CLLocationManager.locationServicesEnabled() {
            
        }
        else{
            
            showAlertLocation(title: "Geolocation is unabled", message: "Do you want to turn it on?", url: URL(string: "App-prefs:root=LOCATION_SERVICES"))
        }
    }
    
    func checkAutorization(){
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            break
        case .denied:
            showAlertLocation(title: "Geolocation is unabled", message: "Do you want to turn it on?", url: URL(string: UIApplication.openSettingsURLString))
            break
        case .restricted:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        @unknown default:
            fatalError()
        }
    }
    func showAlertLocation(title:String,message:String?, url:URL? ){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Options", style: .default) { (alert) in
            if let url = url{
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(settingsAction)
        alert.addAction(cancelAction)
        
        self.presentationControllerGeo?.present(alert, animated: true, completion: nil)
    }
    func formAddres() -> String {
        return finalLocatio
    }
    
    func formCoordinates() ->CLLocationCoordinate2D{
        return finalCoordinate
    }
    
    public func startGeoLocationProccess() {
        self.locationManager.requestLocation()
        
    }
    public func endGeoLocationProccess() {
        self.locationManager.stopUpdatingLocation()
    }
}


extension GeoLocation:CLLocationManagerDelegate{
    
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       
        CLGeocoder().reverseGeocodeLocation(locations.last!, completionHandler: {(placemarks:[CLPlacemark]?, error: Error?) -> Void in
            if let placemarks = placemarks{
                let placemark = placemarks[0]
                self.finalLocatio = (placemark.name ?? "-")
                if placemark.location?.coordinate != nil {
                    self.finalCoordinate = placemark.location!.coordinate
                }
                
                
            }
            
        })
        
    }
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkAutorization()
    }
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print("error:: \(error.localizedDescription)")
        print("dasdffasdfasdfkadkkasdfkaksdfkaskdfkasdkflasdfklasdmflasdmflasdlfasd")
    }
    
}

