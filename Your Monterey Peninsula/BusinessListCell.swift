//
//  BusinessListCell.swift
//  Your Monterey Peninsula
//
//  Created by Nestor Zepeda on 8/22/15.
//  Copyright (c) 2015 NestorZepeda. All rights reserved.
//

import UIKit

class BusinessListCell: UITableViewCell {
    
    @IBOutlet var businessImage: UIImageView!
    @IBOutlet var businessName: UILabel!
    @IBOutlet var offersLabel: UILabel!
    @IBOutlet var distanceLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func loadCell(#businessName: String, offersSubHeader: String, distanceFromUser: String, image: UIImage){
        
        self.businessName.adjustsFontSizeToFitWidth = true
        
        self.businessName.text = businessName
        self.offersLabel.text = offersSubHeader
        self.distanceLabel.text = distanceFromUser
        self.businessImage.image = image
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
