//
//  GiftsTableViewCell.swift
//  Your Monterey Peninsula
//
//  Created by Nestor Zepeda on 10/23/15.
//  Copyright © 2015 NestorZepeda. All rights reserved.
//

import UIKit

class GiftsTableViewCell: UITableViewCell {

    @IBOutlet var iconImage: UIImageView!
    @IBOutlet var descriptionText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
