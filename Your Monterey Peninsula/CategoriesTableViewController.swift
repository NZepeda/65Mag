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
        ("Night Life", "nightlife.jpg")
    ];


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
        
        let categoryToBusiness = "categoryToBusiness"
        
        if segue.identifier == categoryToBusiness{
            if let destination = segue.destinationViewController as? BusinessListTableViewController{
                
                if let cellIndex = tableView.indexPathForSelectedRow()?.row{
                    
                    if cellIndex == 0{
                        var businesslist = Entry()
                        destination.business_list_array = businesslist.getWineTasting() as! [(Business)]
                    }
                }
                
            }
        }
       
    }
    
    
    
    
    
    
    
    
    

}
