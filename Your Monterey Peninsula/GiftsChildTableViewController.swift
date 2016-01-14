//
//  GiftsChildTableViewController.swift
//  Your Monterey Peninsula
//
//  Created by Nestor Zepeda on 10/21/15.
//  Copyright © 2015 NestorZepeda. All rights reserved.
//

import UIKit
import Parse

class GiftsChildTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var offer_array = [PFObject]();
    var business: PFObject!;
    

    @IBOutlet var icon: UIImageView!
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(business.objectId);
        getOffers();
        print(offer_array);
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1;
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return offer_array.count;
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("GiftCell", forIndexPath: indexPath) as! GiftsTableViewCell
        
        let offer:PFObject = offer_array[indexPath.row];
        
        // Configure the cell...
        cell.descriptionText.text = offer["description"] as? String;
        
        if(offer["type"] as? String == "gift"){
            cell.iconImage.image = UIImage(named: "giftIcon");
        }
        else{
            cell.iconImage.image = UIImage(named: "discountIcon");
        }
        
        

        return cell
    }
    
    func getOffers(){
        
        let query = PFQuery(className: "Offers");
        query.whereKey("business", equalTo: business.objectId!);
        
        print(query);
        query.cachePolicy = PFCachePolicy.NetworkElseCache;
        query.findObjectsInBackgroundWithBlock { (results:[PFObject]?, error: NSError?) -> Void in
            if error == nil{
                self.offer_array = results!;
                print(self.offer_array);
                self.tableView.reloadData();
            }
            else{
                print(error);
            }
        }
        
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
