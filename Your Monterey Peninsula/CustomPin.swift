//
//  CustomPin.swift
//  Your Monterey Peninsula
//
//  Created by Nestor Zepeda on 2/21/16.
//  Copyright © 2016 NestorZepeda. All rights reserved.
//

import UIKit
import Parse
import MapKit

class CustomPin: NSObject, MKAnnotation{
    
    var coordinate:CLLocationCoordinate2D;
    var title: String?;
    var subtitle: String?
    var business:PFObject;
    
    init(coordinate:CLLocationCoordinate2D, title:String, subtitle:String, business:PFObject){
        self.coordinate = coordinate;
        self.title = title;
        self.subtitle = subtitle;
        self.business = business;
    }

}
