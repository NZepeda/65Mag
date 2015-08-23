//
//  Business.swift
//  Your Monterey Peninsula
//
//  Created by Nestor Zepeda on 8/7/15.
//  Copyright (c) 2015 NestorZepeda. All rights reserved.
//

import Foundation
import MapKit

class Business: NSObject {
    
    let title: String
    let address: String
    let businessDescription: String
    let url: String
    let facebook: String?
    let businessImage: UIImage
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, address: String, description: String, url: String, facebook: String, businessImage:UIImage, coordinate: CLLocationCoordinate2D){
        
        self.title = title;
        self.address = address;
        self.businessDescription = description;
        self.url = url;
        self.facebook = facebook;
        self.businessImage = businessImage;
        self.coordinate = coordinate;
        
        super.init();
    }

}
