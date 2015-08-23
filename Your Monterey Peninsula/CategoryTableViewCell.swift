//
//  CategoryTableViewCell.swift
//  
//
//  Created by Nestor Zepeda on 8/21/15.
//
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    @IBOutlet var backgroundImage: UIImageView!
    @IBOutlet var cellTitle: UILabel!
   

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func loadCell(#title: String, image: String){
        
        backgroundImage.image = UIImage(named: image);
        cellTitle.text = title;
        cellTitle.textColor = UIColor.whiteColor()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
