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
    
    
    func getObjectsFromParse(type: String) -> Void{
        
        println("I got called!")
        
        let pfobject_array = [PFObject]()
        
        var query = PFQuery(className: "Business")
        query.whereKey("businessType", equalTo: type)
        
        query.findObjectsInBackgroundWithBlock { (results: [AnyObject]?, error: NSError?) -> Void in
            if error != nil{
                //handle error here
                println("error: \(error)")
            }
            else{
                println(results!)
            }
        }
    }
    
    func PFObjectToModelConverter(array_from_parse: NSArray) -> NSArray{
        
        let business_array = [Business]()
        
        for business in array_from_parse{
            
            //convert PFObject into a business model object
            
            var new_business: Business = Business(title: <#String?#>, info: <#String?#>, description: <#String?#>, url: <#String?#>, facebook: <#String?#>, businessImage: <#UIImage?#>, coordinate: <#CLLocationCoordinate2D?#>, distanceFromUser: <#String?#>)
            
        }
        
        return business_array
        
    }
   
}
