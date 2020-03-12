//
//  ViewController.swift
//  DemoMapKit
//
//  Created by Tuan Cuong on 3/5/20.
//  Copyright © 2020 Tuan Cuong. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UISearchBarDelegate {

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
        
//        addAnnotationsOnMapView()
        
        // add annotation array for mapView
        mapView.addAnnotations(self.annotationArray)
    }
    
    
    @IBAction func searchButton(_ sender: Any) {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        present(searchController, animated: true, completion: nil)
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        // khoi tạo control thực hiện event
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = UIActivityIndicatorView.Style.gray
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
//      add activityIndicator vào mainView
        self.view.addSubview(activityIndicator)
        
        //resignFirstResponder : dùng để dismiss keyboard
        searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)
        
        //create the search request
        let searchRequest = MKLocalSearch.Request()
        
        searchRequest.naturalLanguageQuery = searchBar.text
        print("searchRequest.naturalLanguageQuery: \(searchRequest.naturalLanguageQuery)")
        
        //MKLocalSearch: return ve KQ search
        let activeSearch = MKLocalSearch(request: searchRequest)
        
        // Starts the search and delivers the results to the specified completion handler.
        activeSearch.start { (response, error) in
            activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()

            if response ==  nil {
                print("Error: \(String(describing: error))")
            } else {
                // remove annotations
                let anotations = self.mapView.annotations
                self.mapView.removeAnnotations(anotations)
                
                //Getting data
                let latitude = response?.boundingRegion.center.latitude
                let longitude = response?.boundingRegion.center.longitude
                
                let annotation = MKPointAnnotation()
                annotation.title = searchBar.text
                annotation.coordinate = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
                self.mapView.addAnnotation(annotation)
                
                //zooming in on annotaion
                let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude!, longitude!)
                let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                let region = MKCoordinateRegion(center: coordinate, span: span)
                self.mapView.setRegion(region, animated: true)
                
                
                
            }
        }
    }
    
    func addAnnotationsOnMapView() {
        let currentLocation = locationManager.location?.coordinate
        print("CuongTT: \(currentLocation!)")
        setAnnotation(title: "Ahihi", subTitle: "Hello", coordinate: currentLocation!, image: "PNG009")

        
        let destinationLocation = CLLocationCoordinate2D(latitude: 10.796670, longitude: 106.677655)
        setAnnotation(title: "Alo", subTitle: "OLa", coordinate: destinationLocation, image: "PNG003")
        
        
        self.drawLineTwoLocation(sourceLocation: currentLocation!, destinationLocation: destinationLocation)
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

    /*
     draw line two location
     param: sourceLocation:
     param: destinationLocation
    */
    func drawLineTwoLocation(sourceLocation: CLLocationCoordinate2D, destinationLocation: CLLocationCoordinate2D) {
        // Step 1
        //addressDictionary: kieeur dictionnary gom ten duong , dia chi v.v
        // MKPlacemark hiển thị thông tin vị trí trên  
        let sourcePlacemark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
        let destinationPlacemark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
        
        //setp 2
        // MKMapItem: return về 1 mapItem của placemark
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem  = MKMapItem(placemark: destinationPlacemark)
        
        //Step 3
        // direct 2 location
        // MKDirections Yeu cau thuc hien chi duowng
        let directRequest = MKDirections.Request()
        directRequest.source = sourceMapItem
        directRequest.destination = destinationMapItem
        directRequest.transportType = .automobile
        
        // step 4
        let directions = MKDirections(request: directRequest)
        directions.calculate { (response, error) in
            if error == nil {
                // con duong ngat nhat thuong o phat tu dauy tien
                print("CuongTT: \(response?.routes)")
                if let route =  response?.routes.first {
                    self.mapView.addOverlay(route.polyline, level: .aboveRoads)
                    let rect = route.polyline.boundingMapRect
                    
                    self.mapView.setVisibleMapRect(rect, edgePadding: UIEdgeInsets(top: 40, left: 40, bottom: 20, right: 20), animated: true)
                }
            } else {
                print("err: \(error?.localizedDescription)")
            }
        }
        
    }
    
    /*
     render line in MapView
     */
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
         renderer.strokeColor = UIColor.blue
         renderer.lineWidth = 2
        return renderer
    }
    

     

}

