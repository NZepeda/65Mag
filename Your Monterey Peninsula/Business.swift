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
    let info: String?
    let businessDescription: String?
    let url: String?
    let facebook: String?
    let businessImage: UIImage?
    let coordinate: CLLocationCoordinate2D?
    let distanceFromUser: String?
    
    init(title: String?, info: String?, description: String?, url: String?, facebook: String?, businessImage:UIImage?, coordinate: CLLocationCoordinate2D?, distanceFromUser: String?){
        
        self.title = title!;
        self.info = info;
        self.businessDescription = description;
        self.url = url;
        self.facebook = facebook;
        self.businessImage = businessImage;
        self.coordinate = coordinate;
        self.distanceFromUser = distanceFromUser!  
        
        super.init();
    }
    
    

}
