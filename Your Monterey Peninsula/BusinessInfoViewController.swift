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

class BusinessInfoViewController: UIViewController {

    @IBOutlet var businessImage: UIImageView!
    @IBOutlet var businessName: UILabel!
    @IBOutlet var offers: UILabel!
    @IBOutlet var distance: UILabel!
    
    var business: PFObject!
    var distanceFromUser: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpPage()
       
        // Do any additional setup after loading the view.
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

}
