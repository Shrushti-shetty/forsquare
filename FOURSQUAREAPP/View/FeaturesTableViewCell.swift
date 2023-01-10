//
//  FeaturesTableViewCell.swift
//  FOURSQUAREAPP
//
//  Created by Shrushti Shetty on 04/01/23.
//

import UIKit

class FeaturesTableViewCell: UITableViewCell {

    @IBOutlet weak var featuresLabel: UILabel!
    @IBOutlet weak var addFeatureButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
