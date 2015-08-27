//
//  ParseFactory.swift
//  Your Monterey Peninsula
//
//  Created by Nestor Zepeda on 8/25/15.
//  Copyright (c) 2015 NestorZepeda. All rights reserved.
//

import UIKit
import Parse

class ParseFactory: NSObject {
    
    
    func PFObjectToModelConverter(array_from_parse: NSArray) -> NSArray{
        
        var business_array = [Business]()
        
        for business in array_from_parse{
            
            //convert PFObject into a business model object
            print(business["name"])
            let title: String = business["name"] as! String
            let info: String = business["description"] as! String
            let coordinate = CLLocationCoordinate2DMake(36.554075, -121.923281)
            var businessImage = UIImage(named:"asilomar.jpg")
            let imageData: PFFile = business["image"] as! PFFile
           
            
            var new_business: Business = Business(title: title, info: info, description: "some description", url: nil, facebook: nil, businessImage: businessImage, coordinate: coordinate, distanceFromUser: "0.3 mi", imageData: imageData)
            
            business_array.append(new_business)
            
        }
        
        return business_array
        
    }
    
   
}
