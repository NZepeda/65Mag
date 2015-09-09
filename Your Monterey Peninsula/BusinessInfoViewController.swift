//
//  BusinessInfoViewController.swift
//  Your Monterey Peninsula
//
//  Created by Nestor Zepeda on 9/6/15.
//  Copyright (c) 2015 NestorZepeda. All rights reserved.
//

import UIKit
import Parse
import Toucan
import PageMenu

class BusinessInfoViewController: UIViewController {

    @IBOutlet var businessImage: UIImageView!
    @IBOutlet var businessName: UILabel!
    @IBOutlet var offers: UILabel!
    @IBOutlet var distance: UILabel!
    
    @IBOutlet var segmentedControl: UISegmentedControl!
    
    @IBOutlet var infoView: UIView!
    @IBOutlet var giftsView: UIView!
    
    var business: PFObject!
    var distanceFromUser: String!
    
    var PageMenu: CAPSPageMenu?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infoView.hidden = false
        giftsView.hidden = true
        
        setUpPage()
       
        // Do any additional setup after loading the view.
        var controllerArray : [UIViewController] = []
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpPage(){
        businessName.text = business["name"] as? String
        offers.text = business["address"] as? String
        distance.text = distanceFromUser
        
        //get image
        var imageData = business["image"] as! PFFile
        imageData.getDataInBackgroundWithBlock { (data, error) -> Void in
            
            var image:UIImage = UIImage(data: data!)!
            let resizedImage = Toucan.Resize.resizeImage(image, size: CGSize(width: 320.0, height: 150.0), fitMode: Toucan.Resize.FitMode.Clip)
            
            self.businessImage.image = resizedImage
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func tabChanged(sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            infoView.hidden = false
            giftsView.hidden = true
        case 1:
            infoView.hidden = true
            giftsView.hidden = false
        default:
            break;
        }
    }

}