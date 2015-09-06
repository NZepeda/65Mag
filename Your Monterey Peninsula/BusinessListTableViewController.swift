/* MAJOR THING TO DO HERE STILL IS HANDLE CASE WHERE USER LOCATION IS NOT ENABLED*/

import UIKit
import CoreLocation
import Toucan
import Parse

class BusinessListTableViewController: UITableViewController, CLLocationManagerDelegate {
    
    var business_list_array = [PFObject]() //our businesslist
    var type_of_business_to_be_displayed: String = "" //This is the variable used to determine what type of business we will pull from parse
    var userLocation: CLLocation? = nil

    
    override func viewDidLoad() {
        super.viewDidLoad()
        println(userLocation)
        getBusinesses(type_of_business_to_be_displayed)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return business_list_array.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("BusinessCell", forIndexPath: indexPath) as! BusinessListCell
        
        cell.businessName.text = business_list_array[indexPath.row]["name"] as? String
        cell.offersLabel.text = business_list_array[indexPath.row]["address"] as? String
        
        
        /*GET DISTANCE BETWEEN USER AND BUSINESS */
        var point:PFGeoPoint = (business_list_array[indexPath.row]["geoLocation"] as? PFGeoPoint)!
        let loc = CLLocation(latitude: point.latitude, longitude: point.longitude)
        cell.distanceLabel.text = distanceFromBusiness(loc)
        
        /* DISTANCE ENDS HERE */
        
        //get image
        var imageData = business_list_array[indexPath.row]["image"] as! PFFile
        imageData.getDataInBackgroundWithBlock { (data, error) -> Void in
            
            var image:UIImage = UIImage(data: data!)!
            let resizedImage = Toucan.Resize.resizeImage(image, size: CGSize(width: 320.0, height: 150.0), fitMode: Toucan.Resize.FitMode.Clip)
            
            cell.businessImage.image = resizedImage
        }

        return cell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    //MARK: Helper Methods
    
    func getBusinesses(type: String){
        var query = PFQuery(className: "Business")
        var mutableCopyArray: NSMutableArray = []
        query.whereKey("businessType", equalTo: type_of_business_to_be_displayed)
        
        query.cachePolicy = PFCachePolicy.NetworkElseCache //access's network, if its not available, check cache
        
        
        query.findObjectsInBackgroundWithBlock { (results: [AnyObject]?, error: NSError?) -> Void in
            
            if error != nil{
                println(error)
            }
            else{
                
                self.business_list_array = results as! [(PFObject)]
                self.getGeoLocationIfCoordinatesAreNil()
                self.tableView.reloadData()
            }
            
        }
    }
    
    /* This function gets the coordinates of the restaurant based on the 
    address in the DB and updates the DB accordingly*/
    func getGeoLocationIfCoordinatesAreNil(){
        
        for business in business_list_array{
            if business["geoLocation"] == nil{
                
                var address = business["address"] as! String
                var geoCoder = CLGeocoder()
                
                geoCoder.geocodeAddressString(address, completionHandler: { (coordinates: [AnyObject]!, error: NSError?) -> Void in
                    
                    if let placemark = coordinates?[0] as? CLPlacemark {
                        var new_coordinate: PFGeoPoint = PFGeoPoint(latitude: placemark.location.coordinate.latitude, longitude: placemark.location.coordinate.longitude)
                        business["geoLocation"] = new_coordinate
                        
                        business.saveInBackgroundWithBlock({ (success: Bool, error: NSError?) -> Void in
                            
                        })
                      
                    }
        
                })
                
            }
        }
        
    }
    
    //gets the distanc between you and the business
    func distanceFromBusiness(businessLocation: CLLocation) -> String{
        
        let distance = businessLocation.distanceFromLocation(userLocation)
        let distanceString = String(format:"%.1f mi", distance / 1608.344)
        return distanceString
        
    }
    
    
}
