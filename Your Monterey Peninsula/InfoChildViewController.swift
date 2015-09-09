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
    
    @IBOutlet var infoText: UITextView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //var description: String? = object["description"] as! String
        
        infoText.text = description

        // Do any additional setup after loading the view.
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

}
