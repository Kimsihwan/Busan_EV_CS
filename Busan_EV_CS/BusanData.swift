//
//  BusanData.swift
//  Busan_EV_CS
//
//  Created by test on 2018. 11. 6..
//  Copyright © 2018년 ksh. All rights reserved.
//

import Foundation
import MapKit
class BusanData: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
}
}
