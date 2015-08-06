//
//  FirstViewController.swift
//  Your Monterey Peninsula
//
//  Created by Nestor Zepeda on 7/29/15.
//  Copyright (c) 2015 NestorZepeda. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class MapController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet var mapView: MKMapView!
    let regionRadius: CLLocationDistance = 1250;
    let manager = CLLocationManager();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupMap()
        
        //get user current location
        self.manager.delegate = self;
        self.manager.desiredAccuracy = kCLLocationAccuracyBest;
        self.manager.requestWhenInUseAuthorization();
        self.manager.startUpdatingLocation();
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Map functions
    func setupMap(){
        
        let initialLocation = CLLocation(latitude: 36.552647, longitude: -121.9223235);
        self.centerMapOnLocation(initialLocation);
        self.mapView.showsUserLocation = true;
    }
    
    
    func centerMapOnLocation(location: CLLocation) { //centers the map at our location
        
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    //location delegates
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: { (placemarks, error) -> Void in
            
            if error != nil{
                println("Error! " + error.localizedDescription)
                return
            }
            if placemarks.count > 0{
                let pm = placemarks[0] as! CLPlacemark
                self.displayLocationInfo(pm)
            }
            
            
        });
    }
    
    func displayLocationInfo(placemark: CLPlacemark){
        self.manager.stopUpdatingLocation();
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("Error! " + error.localizedDescription);
    }
    
    //Helper Methods
    


}

