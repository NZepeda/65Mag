//
//  BusinessListTableViewController.swift
//  Your Monterey Peninsula
//
//  Created by Nestor Zepeda on 8/22/15.
//  Copyright (c) 2015 NestorZepeda. All rights reserved.
//

import UIKit
import Toucan
import Parse

class BusinessListTableViewController: UITableViewController {
    
    var business_list_array = [PFObject]() //our businesslist
    var type_of_business_to_be_displayed: String = "" //This is the variable used to determine what type of business we will pull from parse

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getBusinesses(type_of_business_to_be_displayed)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

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
        cell.distanceLabel.text = "0.5 mi"
        
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
                self.tableView.reloadData()
            }
            
        }
    }
}
