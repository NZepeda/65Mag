//
//  InfoChildViewController.swift
//  Your Monterey Peninsula
//
//  Created by Nestor Zepeda on 9/9/15.
//  Copyright (c) 2015 NestorZepeda. All rights reserved.
//

import UIKit
import Parse

protocol InfoChildViewControllerDelegate{
    
}

class InfoChildViewController: UIViewController {
    
    var delegate: InfoChildViewControllerDelegate?
    var object: PFObject?
    var text: String?
  
    @IBOutlet var descriptionText: UITextView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionText.text = text!

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func callButtonPressed(sender: UIButton) {
        
        let number: String? = object?.objectForKey("phone") as? String
        
        if number != nil{
            
            var phone = "tel://"
            phone += number!
            
            let url : NSURL = NSURL(string: phone)!
            
            UIApplication.sharedApplication().openURL(url)
        }
        else{
            let alert = UIAlertController(title: "Unavailable", message: "Calling is unavailable", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
       
        
    }

}
