//
//  ViewController.swift
//  DemoMapKit
//
//  Created by Tuan Cuong on 3/5/20.
//  Copyright © 2020 Tuan Cuong. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        // 100 met cap nhat 1 lan
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        // cap quyen cai app
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        // show location trong mapView
        mapView.showsUserLocation = true
        let currentLocation = locationManager.location?.coordinate
        print("CuongTT: \(currentLocation!)")
        setAnnotation(title: "Ahihi", subTitle: "Hello", coordinate: currentLocation!)
    }
    
    func setAnnotation(title: String, subTitle: String, coordinate: CLLocationCoordinate2D)  {
        // Create annotation
        let annotation = CustomAnnotation(title: title, subTitle: subTitle, coordinate: CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude))
        mapView.addAnnotation(annotation )
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // get last location in Array Locations
        let currentLocation = locations.last
        
        // khoi tao toa do
        //MKCoordinateSpan: dooj zoom cua ban do , so cang nho do zoom cang lon 
        let region = MKCoordinateRegion(center: currentLocation!.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            
        // set mapView show current loacation
        mapView.setRegion(region, animated: true)
    }


}

