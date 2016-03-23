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
import Parse


class MapController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet var mapView: MKMapView!
    @IBOutlet var listView: UIScrollView!
    
    let regionRadius: CLLocationDistance = 1250;
    let manager = CLLocationManager();
    var businessArray = [PFObject]();
    var BusinessObject:PFObject?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logoImage = UIImage(named:"65Logo");
        let logoView = UIImageView(image: logoImage);
        
        self.navigationItem.titleView = logoView;
        
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
        
        //center map in carmel
        let initialLocation = CLLocation(latitude: 36.552647, longitude: -121.9223235);
        self.centerMapOnLocation(initialLocation);
        self.mapView.showsUserLocation = true;
        self.mapView.delegate = self;
        
        displayInfo();
    }
    
    
    func centerMapOnLocation(location: CLLocation) { //centers the map at our location
        
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    //location delegates
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: { (placemarks, error) -> Void in
            
            //Do some stuff here
            
        });
    }
    
    func displayLocationInfo(placemark: CLPlacemark){
       
        //do some more stuff here (debugging)
        
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error! " + error.localizedDescription);
    }
    
    //Helper Methods
    func displayInfo(){
        
        //
        for business in businessArray{
            
            //get the position from the business object
            let position = business.objectForKey("geoLocation") as! PFGeoPoint
            
            //get pin coordinate
            let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(position.latitude, position.longitude)
            
            //get title and subtitel
            let title = business.objectForKey("name") as! String;
            let subtitle = business.objectForKey("address") as! String;
            
            let annotation = CustomPin(coordinate: location, title: title, subtitle: subtitle, business: business);

            //set up the annotation
            mapView.addAnnotation(annotation);
        }

        
    }
    
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        
        view.image = UIImage(named:"mapIconSelected");
        let pin = view.annotation as! CustomPin;
        BusinessObject = pin.business;
        
    }
    
    func mapView(mapView: MKMapView, didDeselectAnnotationView view: MKAnnotationView) {
        view.image = UIImage(named: "mapIconNormal");
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        
        if(annotation is MKUserLocation){
            return nil;
        }
        else{
            let reuseId = "pin";
            var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
            
            if pinView == nil {
                pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId);
                pinView?.canShowCallout = true;
                pinView!.image = UIImage(named:"mapIconNormal")!
                pinView!.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure) as UIView;
            }
            else {
                pinView!.annotation = annotation;
            }
            return pinView;
        }
        
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        //When info button is pressed on callout, perform segue with identifier to business page
        if(control == view.rightCalloutAccessoryView){
            performSegueWithIdentifier("MapToBusinessInfo", sender: self);
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "MapToBusinessInfo"){
            let destinationController = segue.destinationViewController as! BusinessInfoViewController;
            destinationController.business = BusinessObject;
        }
    }
    
    
    @IBAction func listButtonPressed(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    



}

