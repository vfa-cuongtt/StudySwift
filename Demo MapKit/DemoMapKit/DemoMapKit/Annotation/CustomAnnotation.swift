//
//  CustomAnnotation.swift
//  DemoMapKit
//
//  Created by Tuan Cuong on 3/5/20.
//  Copyright © 2020 Tuan Cuong. All rights reserved.
//

import MapKit

class CustomAnnotation: NSObject, MKAnnotation {

    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subTitle: String?

    init( title: String, subTitle: String, coordinate: CLLocationCoordinate2D ) {
        self.title = title
        self.subTitle = subTitle
        self.coordinate = coordinate
        
        super.init()
        
    }
    
}
