//
//  CategoriesTableViewController.swift
//  Your Monterey Peninsula
//
//  Created by Nestor Zepeda on 8/21/15.
//  Copyright (c) 2015 NestorZepeda. All rights reserved.
//

import UIKit
import Parse
import CoreLocation

class CategoriesTableViewController: UITableViewController, CLLocationManagerDelegate {
    
    let category_array = [
        ("Restaurants", "restaurants.jpg"),
        ("Shopping", "shopping.jpg"),
        ("Wine Tasting", "wine.jpg"),
        ("Beaches", "beach.jpg"),
        ("Galleries", "gallery.jpg"),
        ("Night Life", "nightlife.jpg"),
       
    ];
    
    var locationManager = CLLocationManager()
    var userLocation: CLLocation? = nil
    
    

    override func viewDidLoad() {
        super.viewDidLoad();
        let logoImage = UIImage(named:"65Logo");
        let logoView = UIImageView(image: logoImage);
        
        self.navigationItem.titleView = logoView;
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        
        if CLLocationManager.locationServicesEnabled(){
            if #available(iOS 9.0, *){
                locationManager.requestWhenInUseAuthorization()
                locationManager.requestLocation()
                print("got called!")
            }
            else{
                print("no i did")
                locationManager.requestWhenInUseAuthorization()
                locationManager.startUpdatingLocation()
            }
        }
        else{
            print("Services not enables")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return self.category_array.count;
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:CategoryTableViewCell = tableView.dequeueReusableCellWithIdentifier("CategoryCell", forIndexPath: indexPath) as! CategoryTableViewCell

        let (title, image) = category_array[indexPath.row]
        
        cell.loadCell(title: title, image: image)
        
        return cell
    }
    

    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let categoryToBusiness = "categoryToBusiness"                                       //This is a segue
        
        if segue.identifier == categoryToBusiness{
            if let destination = segue.destinationViewController as? BusinessListTableViewController{
                
                if let cellIndex = tableView.indexPathForSelectedRow?.row{
                    
                    //Individual cases for when each cell is pressed
                    switch cellIndex{
                    case 0:
                        destination.type_of_business_to_be_displayed = "Restaurant"
                        destination.userLocation = self.userLocation
                        break
                    case 1:
                        destination.type_of_business_to_be_displayed = "Shopping"
                        destination.userLocation = self.userLocation
                        break
                    case 2:
                        destination.type_of_business_to_be_displayed = "Wine Tasting"
                        destination.userLocation = self.userLocation
                        break
                    case 3:
                        destination.type_of_business_to_be_displayed = "Beach"
                        destination.userLocation = self.userLocation
                        break
                    case 4:
                        destination.type_of_business_to_be_displayed = "Galleries"
                        destination.userLocation = self.userLocation
                    case 5:
                        destination.type_of_business_to_be_displayed = "Night Life"
                        destination.userLocation = self.userLocation
                    default: break
                        

                    }
                    
                   
                }
                
            }
        }
       
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        if let location = locations.first{
            userLocation = location
        }
        else{
            print("Why you not working")
        }
        
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error)
    }
    
    
    
    
    
    
    
    
    

}
