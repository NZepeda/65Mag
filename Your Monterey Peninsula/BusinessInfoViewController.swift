//
//  BusinessInfoViewController.swift
//  Your Monterey Peninsula
//
//  Created by Nestor Zepeda on 9/6/15.
//  Copyright (c) 2015 NestorZepeda. All rights reserved.
//

import Foundation
import UIKit
import Parse
import Bolts
import MapKit
import HMSegmentedControl
import AVKit
import AVFoundation

class BusinessInfoViewController: UIViewController, InfoChildViewControllerDelegate {

    @IBOutlet var businessImage: UIImageView!
    @IBOutlet var businessName: UILabel!
    @IBOutlet var offers: UILabel!
    @IBOutlet var distance: UILabel!
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var takeMeThereButton: UIButton!
    @IBOutlet var infoView: UIView!
    @IBOutlet var giftsView: UIView!
    @IBOutlet var videoButton: UIButton!
    
    var control: HMSegmentedControl!
    
    //video
    var playerViewController = AVPlayerViewController();
    var playerView = AVPlayer();
    var trimmedBussiness:String!;
//    var path: NSObject!;
    var url:NSURL!;
    
    
    //objects
    var business: PFObject!
    var distanceFromUser: String!
    var coordinates: PFGeoPoint!
    var imageData: PFFile?=nil;
    var image_array = [UIImage]();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logoImage = UIImage(named:"65Logo");
        let logoView = UIImageView(image: logoImage);
        
        self.navigationItem.titleView = logoView;
        
        segmentedControl.hidden = true
        infoView.hidden = false
        giftsView.hidden = true

        setUpPage()
        
        control = HMSegmentedControl.init(sectionTitles: ["Information", "Gifts"])
        control.frame = CGRectMake(20, 227, 320, 29)
        
        control.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.lightGrayColor()]
        control.selectedTitleTextAttributes = [NSForegroundColorAttributeName: UIColor.blackColor()]
        
        control.selectionIndicatorColor = UIColor.redColor()
        control.selectionIndicatorHeight = 2.0
        control.selectionIndicatorBoxOpacity = 0.8
        control.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe
        control.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown

        control.translatesAutoresizingMaskIntoConstraints = false
        control.addTarget(self, action: Selector("tabChanged:"), forControlEvents: .ValueChanged)
        view.addSubview(control)
        
        let topConstraint = NSLayoutConstraint(item: control, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: businessImage, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 10)
        view.addConstraint(topConstraint)
        
        let leftConstraint = NSLayoutConstraint(item: control, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 16)
        view.addConstraint(leftConstraint)
        
        let rightConstraint = NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: control, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: 16)
        
        view.addConstraint(rightConstraint)
        
        let bottomConstraint = NSLayoutConstraint(item: giftsView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: control, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 1.0)
        
        view.addConstraint(bottomConstraint)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setUpPage(){
        businessName.text = business["name"] as? String
        offers.text = business["address"] as? String
        distance.text = distanceFromUser
        
        //get image
        imageData = business["image"] as? PFFile
        
        if imageData == nil{
            self.businessImage.image = UIImage(named:"defaultbusiness.jpg");
        }
        else{
            getOtherImages();
        
            imageData!.getDataInBackgroundWithBlock { (data, error) -> Void in
            
                let image:UIImage = UIImage(data: data!)!
                self.image_array.append(image);
                self.businessImage.image = image
            }
        }
        
        
        //get other images

        
        if let coordinatesFromParse = business["geoLocation"] as? PFGeoPoint{
            coordinates = coordinatesFromParse
        }
        else{
            takeMeThereButton.enabled = false
            takeMeThereButton.backgroundColor = UIColor.grayColor()
        }
        
        
        //SET UP VIDEO PLAYBACK HERE
        trimmedBussiness = business["name"].stringByReplacingOccurrencesOfString(" ", withString: "");
        trimmedBussiness = trimmedBussiness.lowercaseString;
        
        let path = NSBundle.mainBundle().pathForResource(trimmedBussiness, ofType: "mp4");
        
        if(path == nil){
            print("The thing is nill!");
            videoButton.hidden = true;
        }
        else{
            url = NSURL.fileURLWithPath(path!);
        }
        
        
    }
    
    func getOtherImages(){
        let query = PFQuery(className: "Images");
        
        query.whereKey("business", equalTo: business.objectId!);
        query.findObjectsInBackgroundWithBlock { (results: [PFObject]?, error:NSError?) -> Void in
            if error != nil{
                print(error);
            }
            else{
                                
                //MAKE IMAGES INTO A COLLECTION VIEW
            }
        }
        
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        //segue
        let listToInfo = "InfoSegue"
        let listToGifts = "giftsSegue"
        
        if segue.identifier == listToInfo{
          let infoChildVC = segue.destinationViewController as! InfoChildViewController
            infoChildVC.delegate = self
            infoChildVC.object = business
            infoChildVC.text = business["description"] as? String
            
        }
        
        else if segue.identifier == listToGifts{
            let giftChildVC = segue.destinationViewController as! GiftsChildTableViewController;
            giftChildVC.business = business;
            
        }
    }
    
    @IBAction func takeMeThereButtonPushed(sender: UIButton) {
        
        let latitude : CLLocationDegrees = coordinates.latitude
        let longitude : CLLocationDegrees = coordinates.longitude
        let coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        
        let placemark : MKPlacemark = MKPlacemark(coordinate: coordinate, addressDictionary: nil)
        
        let mapItem : MKMapItem = MKMapItem(placemark: placemark)
        mapItem.name = business.objectForKey("name") as? String
        
        let launchOptions : NSDictionary = NSDictionary(object: MKLaunchOptionsDirectionsModeDriving, forKey: MKLaunchOptionsDirectionsModeKey)
        
        let currentLocationMapItem : MKMapItem = MKMapItem.mapItemForCurrentLocation()
        
        MKMapItem.openMapsWithItems([currentLocationMapItem, mapItem], launchOptions: launchOptions as? [String : AnyObject])
        
    }
    
    @IBAction func tabChanged(sender: UISegmentedControl) {
        switch control.selectedSegmentIndex
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
    
    @IBAction func videoButtonPressed(sender: UIButton) {


        playerView = AVPlayer(URL: url);
        
        playerViewController.player = playerView;
        
        self.presentViewController(playerViewController, animated: true){
            self.playerViewController.player?.play();
        }
        
        
    }
    
    // MARK: - Delegation
    func objectPasser(businessObject: PFObject) {
        
    }

}
