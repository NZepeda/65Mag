//
//  CategoriesTableViewController.swift
//  Your Monterey Peninsula
//
//  Created by Nestor Zepeda on 8/21/15.
//  Copyright (c) 2015 NestorZepeda. All rights reserved.
//

import UIKit

class CategoriesTableViewController: UITableViewController {
    
    let category_array = [
        ("Shopping", "shopping.jpg"),
        ("Wine Tasting", "wine.jpg"),
        ("Beaches", "beach.jpg"),
        ("Galleries", "gallery.jpg"),
        ("Night Life", "nightlife.jpg"),
        ("Restaurants", "restaurants.jpg")
    ];
    
    let factory = ParseFactory()


    override func viewDidLoad() {
        super.viewDidLoad()
        
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
       
        return self.category_array.count;
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:CategoryTableViewCell = tableView.dequeueReusableCellWithIdentifier("CategoryCell", forIndexPath: indexPath) as! CategoryTableViewCell

        var (title, image) = category_array[indexPath.row]
        
        cell.loadCell(title: title, image: image)
        
        return cell
    }
    

    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let categoryToBusiness = "categoryToBusiness"                                       //This is a segue
        
        if segue.identifier == categoryToBusiness{
            if let destination = segue.destinationViewController as? BusinessListTableViewController{
                
                if let cellIndex = tableView.indexPathForSelectedRow()?.row{
                    var businesslist = Entry()
                    
                    switch cellIndex{
                    case 0:
                        destination.business_list_array = businesslist.getShopping() as! [(Business)]
                        break
                    case 1:
                        destination.business_list_array = businesslist.getWineTasting() as! [(Business)]
                        break
                    case 2:
                        destination.business_list_array = businesslist.getBeaches() as! [(Business)]
                        break
                    case 3:
                        factory.getObjectsFromParse("Restaurant")
                        break
                    default:
                        var array:NSMutableArray = []
                        
                        array.addObjectsFromArray(businesslist.getShopping() as [AnyObject])
                        array.addObjectsFromArray(businesslist.getWineTasting() as [AnyObject])         ///TESTING ONLY *DELETE*
                        array.addObjectsFromArray(businesslist.getBeaches() as [AnyObject])
                        
                        destination.business_list_array = array.copy() as! [(Business)]
                        
                    }
                    
                   
                }
                
            }
        }
       
    }
    
    
    
    
    
    
    
    
    

}
