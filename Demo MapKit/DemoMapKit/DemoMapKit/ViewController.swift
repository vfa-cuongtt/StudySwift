//
//  ViewController.swift
//  DemoMapKit
//
//  Created by Tuan Cuong on 3/5/20.
//  Copyright © 2020 Tuan Cuong. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    var annotationArray:[CustomAnnotation] = [CustomAnnotation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
//        pin view thuoc MKMapViewDelegate Protocol
        mapView.delegate = self
        
        // 100 met cap nhat 1 lan
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        // cap quyen cai app
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        // show location trong mapView
        mapView.showsUserLocation = true
        
        addAnnotationsOnMapView()
        
        // add annotation array for mapView
        mapView.addAnnotations(self.annotationArray)
    }
    
    
    func addAnnotationsOnMapView() {
        
        let currentLocation = locationManager.location?.coordinate
        print("CuongTT: \(currentLocation!)")
        setAnnotation(title: "Ahihi", subTitle: "Hello", coordinate: currentLocation!, image: "PNG009")

        
        let destinationLocation = CLLocationCoordinate2D(latitude: 10.796670, longitude: 106.677655)
        setAnnotation(title: "Alo", subTitle: "OLa", coordinate: destinationLocation, image: "PNG003")
    }
    
    func setAnnotation(title: String, subTitle: String, coordinate: CLLocationCoordinate2D, image: String)  {
        // Create annotation
        let annotation = CustomAnnotation(title: title, subTitle: subTitle, coordinate: CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude), image: UIImage(named: image)!)
        
        self.annotationArray.append(annotation)
        
        // Add annotation
//        mapView.addAnnotation(annotation )
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // get last location in Array Locations
        let currentLocation = locations.last
        
        // khoi tao toa do
        //MKCoordinateSpan: dooj zoom cua ban do , so cang nho do zoom cang lon 
        let region = MKCoordinateRegion(center: currentLocation!.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            
        // set mapView show current loacation
        mapView.setRegion(region, animated: true)
        
        // stop update khi re mapview
        locationManager.stopUpdatingLocation()
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let myAnnotation = annotation as? CustomAnnotation {
            
            // cho phep tai su dung lai pinView
            var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: "Custom Pin Anotation View")
            
            if pinView == nil {
                pinView = MKAnnotationView(annotation: myAnnotation, reuseIdentifier: "Custom Pin Anotation View")
                pinView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
                pinView?.canShowCallout = true
                
                // cho biet vij tri cua pinview trong cai annotation
                pinView?.calloutOffset = CGPoint(x: 0, y: 4)
                
                // noi dung ben trong cuar pinView
                pinView?.contentMode = .scaleAspectFill
            } else {
                pinView?.annotation = annotation
            }
            
            // resize image
            let size =  CGSize(width: 50, height: 50)
            UIGraphicsBeginImageContext(size)
            myAnnotation.image?.draw(in: CGRect(x: 0, y: 4, width: size.width, height: size.height))
            let resizeImage = UIGraphicsGetImageFromCurrentImageContext()
            
            pinView?.image = resizeImage
            
            
            return pinView
        }
        return nil
    }


}

