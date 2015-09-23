//
//  BusinessInfoViewController.swift
//  Your Monterey Peninsula
//
//  Created by Nestor Zepeda on 9/6/15.
//  Copyright (c) 2015 NestorZepeda. All rights reserved.
//

import UIKit
import Parse
import Bolts
import MapKit
import HMSegmentedControl

class BusinessInfoViewController: UIViewController, InfoChildViewControllerDelegate {

    @IBOutlet var businessImage: UIImageView!
    @IBOutlet var businessName: UILabel!
    @IBOutlet var offers: UILabel!
    @IBOutlet var distance: UILabel!
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var takeMeThereButton: UIButton!
    @IBOutlet var infoView: UIView!
    @IBOutlet var giftsView: UIView!
    
    var control: HMSegmentedControl!
    
    
    
    
    var business: PFObject!
    var distanceFromUser: String!
    var coordinates: PFGeoPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedControl.hidden = true
        infoView.hidden = false
        giftsView.hidden = true

        print(segmentedControl.frame)
        setUpPage()
        
        control = HMSegmentedControl.init(sectionTitles: ["One", "Two"])
        control.frame = CGRectMake(16, 227, 320, 29)

        control.translatesAutoresizingMaskIntoConstraints = false
        control.addTarget(self, action: Selector("tabChanged:"), forControlEvents: .ValueChanged)
        view.addSubview(control)
        
        let topConstraint = NSLayoutConstraint(item: control, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: businessImage, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 13)
        view.addConstraint(topConstraint)
        
        let leftConstraint = NSLayoutConstraint(item: control, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 16)
        view.addConstraint(leftConstraint)
        
        let rightConstraint = NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: control, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: 16)
        
        view.addConstraint(rightConstraint)
        
        let bottomConstraint = NSLayoutConstraint(item: giftsView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: control, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0.0)
        
        view.addConstraint(bottomConstraint)

    
        //NSLayoutConstraint.activateConstraints([topConstraint, leftConstraint, rightConstraint, bottomConstraint])
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setUpPage(){
        businessName.text = business["name"] as? String
        offers.text = business["address"] as? String
        distance.text = distanceFromUser
        
        //get image
        let imageData = business["image"] as! PFFile
        imageData.getDataInBackgroundWithBlock { (data, error) -> Void in
            
        let image:UIImage = UIImage(data: data!)!
        self.businessImage.image = image
        }
        
        if let coordinatesFromParse = business["geoLocation"] as? PFGeoPoint{
            coordinates = coordinatesFromParse
        }
        else{
            takeMeThereButton.enabled = false
            takeMeThereButton.backgroundColor = UIColor.grayColor()
        }
        
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        //segue
        let listToInfo = "InfoSegue"
        
        if segue.identifier == listToInfo{
          let infoChildVC = segue.destinationViewController as! InfoChildViewController
            infoChildVC.delegate = self
            infoChildVC.object = business
            infoChildVC.text = business["description"] as? String
            
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
    
    // MARK: - Delegation
    func objectPasser(businessObject: PFObject) {
        
    }

}
